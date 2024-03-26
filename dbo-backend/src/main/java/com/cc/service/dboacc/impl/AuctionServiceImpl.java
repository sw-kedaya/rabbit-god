package com.cc.service.dboacc.impl;

import cn.hutool.core.codec.Base64;
import com.cc.entity.Auction;
import com.cc.entity.CommonConstant;
import com.cc.mapper.dboacc.AuctionMapper;
import com.cc.service.dboacc.IAuctionService;
import com.cc.vo.Result;
import org.springframework.stereotype.Service;
import org.springframework.util.FastByteArrayOutputStream;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.sql.Blob;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class AuctionServiceImpl implements IAuctionService {
    @Resource
    private AuctionMapper auctionMapper;

    @Override
    public Result adminSaveAuction(Auction auction) {
        return auctionMapper.adminSaveAuction(auction) > 0 ? Result.ok() : Result.fail("新增拍卖商品失败..");
    }

    @Override
    public Result adminGetAuctionList() {
        List<Auction> list = auctionMapper.adminGetAuctionList();
        for (Auction auction : list) {
            parseStatus(auction);

            // 将 BLOB 数据转换为 BufferedImage
            byte[] imageData = auction.getMallIcon();
            ByteArrayInputStream inputStream = new ByteArrayInputStream(imageData);
            // 转换流信息写出
            FastByteArrayOutputStream os = new FastByteArrayOutputStream();
            try
            {
                BufferedImage image = ImageIO.read(inputStream);
                ImageIO.write(image, "png", os);
            }
            catch (IOException e)
            {
                return Result.fail(e.getMessage());
            }
            auction.setImage(Base64.encode(os.toByteArray()));
        }
        return Result.ok(list);
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
}
