package com.cc.mapper.dboacc;

import com.cc.entity.AuctionOrder;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AuctionOrderMapper {
    void createOrder(AuctionOrder auctionOrder);

    void updatePrice(@Param("auctionID") Long auctionID,
                     @Param("accountID") Long accountID,
                     @Param("price") Long price);

    Integer isExist(@Param("auctionID") Long auctionID,
                    @Param("accountID") Long accountID);

    List<AuctionOrder> userGetAuctionOrder(@Param("accountID") Long userId);

    Integer setFailedStatus(@Param("auctionID") Long auctionID);

    Integer setSuccessStatus(@Param("auctionID") Long auctionID,
                             @Param("accountID") Long accountID);
}
