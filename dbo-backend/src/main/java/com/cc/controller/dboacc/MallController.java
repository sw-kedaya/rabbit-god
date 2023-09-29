package com.cc.controller.dboacc;

import com.cc.entity.Mall;
import com.cc.service.dboacc.IAccountService;
import com.cc.service.dboacc.IMallService;
import com.cc.vo.Result;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/mall")
public class MallController {
    @Resource
    private IMallService mallService;
    @Resource
    private IAccountService accountService;

    @GetMapping("/list")
    public Result getMallList() {
        return mallService.getMallList();
    }

    @PostMapping("/admin/save")
    public Result saveMall(@RequestBody Mall mall) {
        if (!accountService.isAdmin(mall.getUserId())) return Result.fail("禁止非管理员操作");
        return mallService.saveMall(mall);
    }

    @PutMapping("/admin/update")
    public Result updateMall(@RequestBody Mall mall) {
        if (!accountService.isAdmin(mall.getUserId())) return Result.fail("禁止非管理员操作");
        return mallService.updateMall(mall);
    }

    @DeleteMapping("/admin/delete")
    public Result deleteMallById(Long id, Long userId) {
        if (!accountService.isAdmin(userId)) return Result.fail("禁止非管理员操作");
        return mallService.deleteMallById(id);
    }

    @PutMapping("/admin/set")
    public Result setSignRewardById(Long id, Long userId) {
        if (!accountService.isAdmin(userId)) return Result.fail("禁止非管理员操作");
        return mallService.setSignRewardById(id);
    }

    @PutMapping("/admin/cancel")
    public Result cancelSignRewardById(Long id, Long userId) {
        if (!accountService.isAdmin(userId)) return Result.fail("禁止非管理员操作");
        return mallService.cancelSignRewardById(id);
    }

    @GetMapping("/admin/list")
    public Result getAdminEnableMallList() {
        return mallService.getAdminEnableMallList();
    }

    @GetMapping("/admin/all/list")
    public Result getAdminAllMallList() {
        return mallService.getAdminAllMallList();
    }
}
