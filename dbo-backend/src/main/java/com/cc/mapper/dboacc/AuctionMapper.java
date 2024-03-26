package com.cc.mapper.dboacc;

import com.cc.entity.Auction;
import com.cc.vo.Result;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface AuctionMapper {
    Integer adminSaveAuction(Auction auction);

    List<Auction> adminGetAuctionList();

    Integer adminUpdateAuction(Auction auction);

    Integer adminDeleteAuction(@PathVariable("id") Long id);
}
