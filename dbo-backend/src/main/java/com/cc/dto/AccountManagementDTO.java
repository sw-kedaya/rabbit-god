package com.cc.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class AccountManagementDTO {
    private Long accountID;
    private String username;
    private String email;
    private LocalDateTime regDate;
    private String regIp;
    private LocalDateTime lastLogin;
    private String lastIp;
    private String accStatus;
    private Long mallPoints;
    private Long waguCoins;
    private Long eventCoins;
    private Long auctionPoint;
}
