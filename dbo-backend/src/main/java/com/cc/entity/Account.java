package com.cc.entity;

import lombok.Data;

import java.time.LocalDateTime;
@Data
public class Account {
    private Integer accountID;
    private String username;
    private String password;
    private String accStatus;
    private String email;
    private Integer mallPoints;
    private Integer eventCoins;
    private Integer waguCoins;
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
    private Integer firstCharID;
}
