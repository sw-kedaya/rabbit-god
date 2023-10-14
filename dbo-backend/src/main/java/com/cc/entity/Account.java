package com.cc.entity;

import lombok.Data;

import java.time.LocalDateTime;
@Data
public class Account {
    private Long accountID;
    private String username;
    private String password;
    private String accStatus;
    private String email;
    private Long mallPoints;
    private Long eventCoins;
    private Long waguCoins;
    private LocalDateTime regDate;
    private LocalDateTime lastLogin;
    private String regIp;
    private Integer admin;
    private Integer isGm;
    private Integer lastServerFarmId;
    private Integer founder;
    private Integer founderRecv;
    private String lastIp;
    private String delCharPw;
    private Integer premiumSlots;
    private String webIp;
    private Integer bansCount;
    private Integer bansEnd;
    private String bz;
    private Integer newPlayer;
    private Long firstCharID;
    /** 新增：补签卡和数量限制 */
    private Integer replacementCard;
    private Integer cardCountLimit;
}
