package com.cc.controller.dboacc;

import com.cc.entity.CashKey;
import com.cc.service.dboacc.ICashKeyService;
import com.cc.vo.Result;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/cash")
public class CashKeyController {
    @Resource
    private ICashKeyService cashKeyService;

    @GetMapping("/order")
    public Result userOrder(String accountID) {
        return cashKeyService.userOrder(accountID);
    }

    @PostMapping("/use")
    public Result useCdKey(@RequestBody CashKey cashkey){
        return cashKeyService.useCdKey(cashkey);
    }
}
