package com.cc.entity;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class MallOrder {
    private Long id;
    private Long mallId;
    private String mallName;
    private String mallDesc;
    private Long price;
    private Long accountID;
    private Long charID;
    private String charName;
    private LocalDateTime buyTime;
}
