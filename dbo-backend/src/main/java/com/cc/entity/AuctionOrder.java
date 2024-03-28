package com.cc.entity;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class AuctionOrder {
    private Long id;
    private Long auctionID;
    private Long accountID;
    private String CharName;
    private Long price = 0L;
    private LocalDateTime createTime;
    private String status;
    private Byte isEnd;
    private String mallName;
    private Long successPrice;
}
