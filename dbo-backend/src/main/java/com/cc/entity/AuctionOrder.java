package com.cc.entity;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class AuctionOrder {
    private Long id;
    private Long auctionID;
    private Long accountID;
    private LocalDateTime createTime;
    private String status;
    private Byte isEnd;
}
