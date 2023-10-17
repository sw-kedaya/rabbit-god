package com.cc.mapper.dboacc;

import com.cc.entity.WpShop;

import java.util.List;

public interface WpShopMapper {
    List<WpShop> adminGetAllWpShopList();

    Integer adminSaveWpShop(WpShop wpShop);

    Integer adminUpdateWpShop(WpShop wpShop);

    Integer adminDeleteWpShopById(Long id);
}
