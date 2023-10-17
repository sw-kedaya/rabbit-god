package com.cc.service.dboacc;

import com.cc.entity.WpShop;
import com.cc.vo.Result;

public interface IWpShopService {
    Result adminGetAllWpShopList();

    Result adminSaveWpShop(WpShop wpShop);

    Result adminUpdateWpShop(WpShop wpShop);

    Result adminDeleteWpShopById(Long id);
}
