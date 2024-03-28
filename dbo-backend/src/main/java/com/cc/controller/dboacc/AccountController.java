package com.cc.controller.dboacc;

import com.cc.dto.AccountDTO;
import com.cc.dto.AccountManagementDTO;
import com.cc.dto.PasswordDTO;
import com.cc.service.dboacc.IAccountService;
import com.cc.util.JwtUtils;
import com.cc.util.ThreadLocalUtils;
import com.cc.vo.Result;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/user")
public class AccountController {
    @Resource
    private IAccountService accountService;

    @PostMapping("/open/register")
    public Result register(@RequestBody AccountDTO accountDTO, HttpServletRequest request) {
        return accountService.register(accountDTO, request);
    }

    @PostMapping("/open/login")
    public Result login(@RequestBody AccountDTO accountDTO) {
        return accountService.login(accountDTO);
    }

    @GetMapping("/open/logout")
    public Result logout(String token) {
        return accountService.logout(token);
    }

    @GetMapping("/open/check")
    public Result checkToken(String token) {
        return Result.ok(JwtUtils.checkToken(token));
    }

    @GetMapping("/open/forget")
    public Result forgetPassword(String username) {
        return accountService.forgetPassword(username);
    }

    @PostMapping("/update")
    public Result updatePwd(@RequestBody PasswordDTO passwordDTO) {
        return accountService.updatePwd(passwordDTO);
    }

    @GetMapping("/latest")
    public Result getLatestMallPoints(Long id) {
        return accountService.getLatestMallPoints(id);
    }

    @GetMapping("/cardCount")
    public Result getCardCount(Long id) {
        return accountService.getCardCount(id);
    }

    @GetMapping("/admin/list")
    public Result adminGetList() {
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return accountService.adminGetList();
    }

    @PutMapping("/admin/update")
    public Result adminUpdateBalance(@RequestBody AccountManagementDTO accountManagementDTO) {
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return accountService.adminUpdateBalance(accountManagementDTO);
    }

    @GetMapping("/admin/block")
    public Result blockedAccount(Long id) {
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return accountService.blockedAccount(id);
    }

    @GetMapping("/admin/unblock")
    public Result unblockedAccount(Long id) {
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return accountService.unblockedAccount(id);
    }
}
