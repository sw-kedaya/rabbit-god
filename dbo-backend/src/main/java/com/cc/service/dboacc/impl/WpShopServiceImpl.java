package com.cc.service.dboacc.impl;

import com.cc.entity.WpShop;
import com.cc.mapper.dboacc.WpShopMapper;
import com.cc.service.dboacc.IWpShopService;
import com.cc.vo.Result;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class WpShopServiceImpl implements IWpShopService {
    @Resource
    private WpShopMapper wpShopMapper;

    @Override
    public Result adminGetAllWpShopList() {
        return Result.ok(wpShopMapper.adminGetAllWpShopList());
    }

    @Override
    public Result adminSaveWpShop(WpShop wpShop) {
        Integer integer = wpShopMapper.adminSaveWpShop(wpShop);
        return integer > 0 ? Result.ok() : Result.fail("添加失败，请检查WP数据");
    }

    @Override
    public Result adminUpdateWpShop(WpShop wpShop) {
        Integer integer = wpShopMapper.adminUpdateWpShop(wpShop);
        return integer > 0 ? Result.ok() : Result.fail("修改失败，请刷新后检查数据");
    }

    @Override
    public Result adminDeleteWpShopById(Long id) {
        Integer integer = wpShopMapper.adminDeleteWpShopById(id);
        return integer > 0 ? Result.ok() : Result.fail("删除失败，请刷新后检查数据");
    }
}
