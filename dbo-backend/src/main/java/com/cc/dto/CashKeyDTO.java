package com.cc.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class CashKeyDTO {
    private Long id;
    private String cdKey;
    private Long cash;
    private LocalDateTime createTime;
    private LocalDateTime useTime;
    private Long accountID;
    private String roleName;
}
