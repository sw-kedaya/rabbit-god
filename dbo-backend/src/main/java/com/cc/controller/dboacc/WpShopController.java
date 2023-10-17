package com.cc.controller.dboacc;

import com.cc.entity.WpShop;
import com.cc.service.dboacc.IWpShopService;
import com.cc.vo.Result;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/wpShop")
public class WpShopController {
    @Resource
    private IWpShopService wpShopService;

    @GetMapping("/list")
    public Result adminGetAllWpShopList() {
        return wpShopService.adminGetAllWpShopList();
    }

    @PostMapping("/save")
    public Result adminSaveWpShop(@RequestBody WpShop wpShop) {
        return wpShopService.adminSaveWpShop(wpShop);
    }

    @PutMapping("/update")
    public Result adminUpdateWpShop(@RequestBody WpShop wpShop) {
        return wpShopService.adminUpdateWpShop(wpShop);
    }

    @DeleteMapping("/delete")
    public Result adminDeleteWpShopById(Long id) {
        return wpShopService.adminDeleteWpShopById(id);
    }
}
