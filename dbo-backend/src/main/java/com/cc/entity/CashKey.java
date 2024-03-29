package com.cc.entity;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class CashKey {
    private Long id;
    private String cdKey;
    private Long cash;
    private LocalDateTime createTime;
    private LocalDateTime useTime;
    private Long accountID;
}
