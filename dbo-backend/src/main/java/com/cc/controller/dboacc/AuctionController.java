package com.cc.controller.dboacc;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.json.JSONUtil;
import com.cc.entity.Auction;
import com.cc.entity.CommonConstant;
import com.cc.service.dboacc.IAccountService;
import com.cc.service.dboacc.IAuctionService;
import com.cc.util.ThreadLocalUtils;
import com.cc.vo.Result;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.IOException;
import java.time.LocalDateTime;

@RestController
@RequestMapping("/auctions")
public class AuctionController {
    @Resource
    private IAccountService accountService;
    @Resource
    private IAuctionService auctionService;

    @PostMapping("/admin/save")
    public Result adminSaveAuction(MultipartFile file, String auctionJson) {
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        Result result;
        try {
            byte[] bytes = file.getBytes();
            Auction auction = JSONUtil.toBean(auctionJson, Auction.class);
            auction.setMallIcon(bytes);
            auctionService.parseStatus(auction);
            result = auctionService.adminSaveAuction(auction);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    @GetMapping("/admin/list")
    public Result adminGetAuctionList(){
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return auctionService.adminGetAuctionList();
    }

    @PutMapping("/admin/update")
    public Result adminUpdateAuction(MultipartFile file, String auctionJson) {
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        Result result;
        try {
            Auction auction = JSONUtil.toBean(auctionJson, Auction.class);
            if (file != null) {
                byte[] bytes = file.getBytes();
                auction.setMallIcon(bytes);
            }else {
                auction.setMallIcon(null);
            }
            auctionService.parseStatus(auction);
            result = auctionService.adminUpdateAuction(auction);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return result;
    }


    @DeleteMapping("/admin/delete")
    public Result adminDeleteAuction(Long id){
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return auctionService.adminDeleteAuction(id);
    }
}
