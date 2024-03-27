package com.cc.entity;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Auction {
    private Long id;
    private Long mallId;
    private String mallName;
    private byte[] mallIcon;
    private String image;
    private Long startingPrice;
    private Long currentPrice;
    private Long lowestMakeup;
    private LocalDateTime shelfTime;
    private LocalDateTime endTime;
    private Long accountID;
    private String charName;
    private String status;
    private Byte isGrant;
}
