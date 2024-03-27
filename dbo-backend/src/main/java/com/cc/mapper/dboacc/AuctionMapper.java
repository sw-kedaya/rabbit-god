package com.cc.mapper.dboacc;

import com.cc.entity.Auction;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AuctionMapper {
    Integer adminSaveAuction(Auction auction);

    List<Auction> adminGetAuctionList();

    Integer adminUpdateAuction(Auction auction);

    Integer adminDeleteAuction(@Param("id") Long id);

    List<Auction> getListForUser();

    boolean isBidSuccess(@Param("id") Long auctionId,
                         @Param("price") Long price);

    Auction getCurrentAccountID(@Param("id") Long auctionId);

    Integer updateAccountID(@Param("id") Long auctionId,
                            @Param("accountID") Long userId,
                            @Param("price") Long price);
}
