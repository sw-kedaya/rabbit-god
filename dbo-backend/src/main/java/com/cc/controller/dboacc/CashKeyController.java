package com.cc.controller.dboacc;

import com.cc.entity.CashKey;
import com.cc.service.dboacc.IAccountService;
import com.cc.service.dboacc.ICashKeyService;
import com.cc.vo.Result;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/cash")
public class CashKeyController {
    @Resource
    private ICashKeyService cashKeyService;
    @Resource
    private IAccountService accountService;

    @GetMapping("/admin/order")
    public Result order(Long userId){
        if (!accountService.isAdmin(userId)) return Result.fail("禁止非管理员操作");
        return cashKeyService.adminGetCashKeyList();
    }

    @GetMapping("/admin/save")
    public Result adminAddCashKey(Long cash, Long num, Long userId) {
        if (!accountService.isAdmin(userId)) return Result.fail("禁止非管理员操作");
        return cashKeyService.adminAddCashKey(cash,num);
    }

    @DeleteMapping("/admin/delete")
    public Result deleteAllKey() {
        return cashKeyService.deleteAllKey();
    }

    @GetMapping("/order")
    public Result userOrder(String accountID) {
        return cashKeyService.userOrder(accountID);
    }

    @PostMapping("/use")
    public Result useCdKey(@RequestBody CashKey cashkey){
        return cashKeyService.useCdKey(cashkey);
    }
}
