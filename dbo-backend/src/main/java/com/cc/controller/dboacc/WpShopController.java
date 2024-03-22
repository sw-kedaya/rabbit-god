package com.cc.controller.dboacc;

import com.cc.entity.WpShop;
import com.cc.service.dboacc.IAccountService;
import com.cc.service.dboacc.IWpShopService;
import com.cc.util.ThreadLocalUtils;
import com.cc.vo.Result;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/wpShop")
public class WpShopController {
    @Resource
    private IWpShopService wpShopService;
    @Resource
    private IAccountService accountService;

    @GetMapping("/admin/list")
    public Result adminGetAllWpShopList() {
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return wpShopService.adminGetAllWpShopList();
    }

    @PostMapping("/admin/save")
    public Result adminSaveWpShop(@RequestBody WpShop wpShop) {
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return wpShopService.adminSaveWpShop(wpShop);
    }

    @PutMapping("/admin/update")
    public Result adminUpdateWpShop(@RequestBody WpShop wpShop) {
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return wpShopService.adminUpdateWpShop(wpShop);
    }

    @DeleteMapping("/admin/delete")
    public Result adminDeleteWpShopById(Long id) {
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return wpShopService.adminDeleteWpShopById(id);
    }
}
