package com.cc.controller.dbochar;

import com.cc.service.dbochar.IDBOCharService;
import com.cc.vo.Result;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/char")
public class DBOCharController {

    @Value("${signin.open}")
    private boolean isOpenSignIn;

    @Resource
    private IDBOCharService dboCharService;

    @GetMapping("/list")
    public Result getDBOCharList(Long accountID){
        return dboCharService.getDBOCharList(accountID);
    }

    @GetMapping("sign")
    public Result setSign(String charName, Long accountID) {
        if (!isOpenSignIn) return Result.fail("管理员未开启签到");
        return dboCharService.setSign(charName, accountID);
    }

    @GetMapping("sign/check")
    public Result checkIsSign(Long accountID) {
        if (!isOpenSignIn) return Result.fail("管理员未开启签到");
        return dboCharService.checkIsSign(accountID);
    }

    @GetMapping("sign/message")
    public Result getSignMessage(String roleName){
        return dboCharService.getSignMessage(roleName);
    }
}
