package com.cc.mapper.dboacc;

import com.cc.entity.AuctionOrder;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AuctionOrderMapper {
    void createOrder(AuctionOrder auctionOrder);

    Integer isExist(@Param("auctionID") Long auctionID,
                    @Param("accountID") Long accountID);

    List<AuctionOrder> userGetAuctionOrder(@Param("accountID") Long userId);
}
