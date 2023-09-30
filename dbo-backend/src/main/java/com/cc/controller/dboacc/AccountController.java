package com.cc.controller.dboacc;

import com.cc.dto.AccountDTO;
import com.cc.dto.PasswordDTO;
import com.cc.service.dboacc.IAccountService;
import com.cc.util.JwtUtils;
import com.cc.vo.Result;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/user")
public class AccountController {
    @Resource
    private IAccountService accountService;

    @PostMapping("/register")
    public Result register(@RequestBody AccountDTO accountDTO, HttpServletRequest request) {
        return accountService.register(accountDTO, request);
    }

    @PostMapping("/login")
    public Result login(@RequestBody AccountDTO accountDTO){
        return accountService.login(accountDTO);
    }

    @GetMapping("/check")
    public Result checkToken(String token){
        return Result.ok(JwtUtils.checkToken(token));
    }

    @GetMapping("/forget")
    public Result forgetPassword(String username){
        return accountService.forgetPassword(username);
    }

    @PostMapping("/update")
    public Result updatePwd(@RequestBody PasswordDTO passwordDTO){
        return accountService.updatePwd(passwordDTO);
    }

    @GetMapping("/latest")
    public Result getLatestMallPoints(Long id) {
        return accountService.getLatestMallPoints(id);
    }
}
