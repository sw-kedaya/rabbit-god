package com.cc.service.dboacc;

import com.cc.entity.Auction;
import com.cc.vo.Result;

public interface IAuctionService {
    Result adminSaveAuction(Auction auction);

    Result adminGetAuctionList();

    void parseStatus(Auction auction);

    Result adminUpdateAuction(Auction auction);

    Result adminDeleteAuction(Long id);
}
