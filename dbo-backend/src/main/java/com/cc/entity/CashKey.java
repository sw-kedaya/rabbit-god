package com.cc.entity;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class CashKey {
    private Integer id;
    private String cdKey;
    private Integer cash;
    private LocalDateTime createTime;
    private LocalDateTime useTime;
    private Integer accountID;
}
