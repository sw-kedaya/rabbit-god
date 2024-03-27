package com.cc.service.dboacc.impl;

import cn.hutool.core.codec.Base64;
import com.cc.entity.Auction;
import com.cc.entity.AuctionOrder;
import com.cc.entity.CommonConstant;
import com.cc.mapper.dboacc.AuctionMapper;
import com.cc.mapper.dboacc.AuctionOrderMapper;
import com.cc.mapper.dbochar.DBOCharMapper;
import com.cc.service.dboacc.IAccountService;
import com.cc.service.dboacc.IAuctionService;
import com.cc.util.ThreadLocalUtils;
import com.cc.vo.Result;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FastByteArrayOutputStream;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.concurrent.locks.ReentrantLock;

@Service
public class AuctionServiceImpl implements IAuctionService {
    private static final ReentrantLock lock = new ReentrantLock();

    @Resource
    private AuctionMapper auctionMapper;
    @Resource
    private IAccountService accountService;
    @Resource
    private AuctionOrderMapper auctionOrderMapper;
    @Resource
    private DBOCharMapper dboCharMapper;

    @Override
    public Result adminSaveAuction(Auction auction) {
        return auctionMapper.adminSaveAuction(auction) > 0 ? Result.ok() : Result.fail("新增拍卖商品失败..");
    }

    @Override
    public Result adminGetAuctionList() {
        List<Auction> list = auctionMapper.adminGetAuctionList();
        for (Auction auction : list) {
            parseStatus(auction); // 解析状态
            setImg(auction); // 解析图片
        }
        return Result.ok(list);
    }

    private void setImg(Auction auction) {
        // 将 BLOB 数据转换为 BufferedImage
        byte[] imageData = auction.getMallIcon();
        ByteArrayInputStream inputStream = new ByteArrayInputStream(imageData);
        // 转换流信息写出
        FastByteArrayOutputStream os = new FastByteArrayOutputStream();
        try {
            BufferedImage image = ImageIO.read(inputStream);
            ImageIO.write(image, "png", os);
        } catch (IOException e) {
            throw new RuntimeException();
        }
        auction.setImage(Base64.encode(os.toByteArray()));
    }

    @Override
    public void parseStatus(Auction auction) {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime shelfTime = auction.getShelfTime();
        LocalDateTime endTime = auction.getEndTime();
        // 设置状态
        if (now.isBefore(shelfTime)) auction.setStatus(CommonConstant.AUCTION_STATUS_UNSTARTED);
        else if (now.isAfter(endTime)) auction.setStatus(CommonConstant.AUCTION_STATUS_ENDING);
        else auction.setStatus(CommonConstant.AUCTION_STATUS_ONGOING);
    }

    @Override
    public Result adminUpdateAuction(Auction auction) {
        return auctionMapper.adminUpdateAuction(auction) > 0 ? Result.ok() : Result.fail("修改拍卖商品失败..");
    }

    @Override
    public Result adminDeleteAuction(Long id) {
        return auctionMapper.adminDeleteAuction(id) > 0 ? Result.ok() : Result.fail("删除拍卖商品失败, 请刷新页面");
    }

    @Override
    public Result getListForUser() {
        List<Auction> list = auctionMapper.getListForUser();
        for (Auction auction : list) {
            setImg(auction); // 解析图片
            // 设置用户角色名
            String charName = dboCharMapper.getCharNameByID(auction.getAccountID());
            if (charName == null || charName.isEmpty()) {
                auction.setCharName("无");
            } else {
                auction.setCharName(charName);
            }
        }
        return Result.ok(list);
    }

    @Transactional("dboAccTransactionManager")
    @Override
    public Result userAttendAuction(Long auctionId, Long price) {
        // 加锁
        lock.lock();
        try {
            // 1.核对加价是否符合
            if (!auctionMapper.isBidSuccess(auctionId, price)) return Result.fail("加价价格错误,请刷新页面");
            // 2.扣款
            if (!accountService.isAuctionPointEnoughById(ThreadLocalUtils.getUserId(), price)) {
                return Result.fail("拍卖点数不足");
            }
            // 3.将被顶替的上一位拍卖者的余额退回（先获取id和当前竞拍价格）
            Auction auction = auctionMapper.getCurrentAccountID(auctionId);
            if (auction != null && auction.getAccountID() != null) {
                if (accountService.returnAuctionPrice(auction.getAccountID(),
                        auction.getCurrentPrice()) <= 0) {
                    throw new RuntimeException("数据库出错");
                }
            }
            // 4.更新拍卖信息
            if (auctionMapper.updateAccountID(auctionId, ThreadLocalUtils.getUserId(), price) <= 0) {
                throw new RuntimeException("数据库出错");
            }
            // 5.创建订单
            if (auctionOrderMapper.isExist(auctionId, ThreadLocalUtils.getUserId()) <= 0) {
                AuctionOrder auctionOrder = new AuctionOrder();
                auctionOrder.setAccountID(ThreadLocalUtils.getUserId());
                auctionOrder.setAuctionID(auctionId);
                auctionOrder.setCreateTime(LocalDateTime.now());
                auctionOrderMapper.createOrder(auctionOrder);
            }
        } finally {
            lock.unlock();
        }
        return Result.ok();
    }

    @Override
    public Result userGetAuctionOrder() {
        return Result.ok(auctionOrderMapper.userGetAuctionOrder(ThreadLocalUtils.getUserId()));
    }
}
