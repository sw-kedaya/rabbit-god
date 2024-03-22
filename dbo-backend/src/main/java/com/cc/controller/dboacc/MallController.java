package com.cc.controller.dboacc;

import com.cc.dto.MallAndPurchaserDTO;
import com.cc.dto.MallSignDTO;
import com.cc.entity.Mall;
import com.cc.entity.Purchaser;
import com.cc.service.dboacc.IAccountService;
import com.cc.service.dboacc.IMallService;
import com.cc.util.ThreadLocalUtils;
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
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return mallService.saveMall(mall);
    }

    @PutMapping("/admin/update")
    public Result updateMall(@RequestBody Mall mall) {
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return mallService.updateMall(mall);
    }

    @DeleteMapping("/admin/delete")
    public Result deleteMallById(Long id) {
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return mallService.deleteMallById(id);
    }

    @PutMapping("/admin/set")
    public Result setSignRewardById(@RequestBody MallSignDTO dto) {
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return mallService.setSignRewardById(dto);
    }

    @PutMapping("/admin/cancel")
    public Result cancelSignRewardById(Long id) {
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return mallService.cancelSignRewardById(id);
    }

    @GetMapping("/admin/list")
    public Result getAdminEnableMallList() {
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return mallService.getAdminEnableMallList();
    }

    @GetMapping("/admin/all/list")
    public Result getAdminAllMallList() {
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return mallService.getAdminAllMallList();
    }

    @PostMapping("/buyOrGive")
    public Result buyOrGiveMallPresent(@RequestBody MallAndPurchaserDTO dto){
        return mallService.buyOrGiveMallPresent(dto.getMall(), dto.getPurchaser());
    }

    @GetMapping("/sign/message")
    public Result getCurrentSignRewardMessage(){
        return mallService.getCurrentSignRewardMessage();
    }
}
