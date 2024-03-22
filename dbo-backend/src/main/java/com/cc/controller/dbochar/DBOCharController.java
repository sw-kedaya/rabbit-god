package com.cc.controller.dbochar;

import com.cc.dto.CharManagementDTO;
import com.cc.service.dboacc.IAccountService;
import com.cc.service.dbochar.IDBOCharService;
import com.cc.util.ThreadLocalUtils;
import com.cc.vo.Result;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/char")
public class DBOCharController {

    @Value("${signin.open}")
    private boolean isOpenSignIn;

    @Resource
    private IDBOCharService dboCharService;
    @Resource
    private IAccountService accountService;

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

    @GetMapping("sign/activity")
    public Result checkActivity(Long accountID){
        return dboCharService.checkActivity(accountID);
    }

    @GetMapping("sign/replacement")
    public Result replacementSign(Long accountID, String roleName, Integer day,
                                  Long itemId, Long count){
        return dboCharService.replacementSign(accountID, roleName, day, itemId, count);
    }

    @GetMapping("rank/activity")
    public Result getActivityRank(){
        return dboCharService.getActivityRank();
    }

    @GetMapping("rank/money")
    public Result getMoneyRank(){
        return dboCharService.getMoneyRank();
    }


    @GetMapping("/admin/list")
    public Result adminGetCharacterList(){
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return dboCharService.adminGetCharacterList();
    }

    @PutMapping("/admin/update")
    public Result adminUpdateCharacter(@RequestBody CharManagementDTO dto){
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return dboCharService.adminUpdateCharacter(dto);
    }
}
