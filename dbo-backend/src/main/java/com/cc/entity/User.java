package com.cc.entity;

import lombok.Data;

@Data
public class User {
    private Long accountID;
    private String username;
    private String accStatus;
    private String email;
    // 余额
    private Long mallPoints;
    // 现金扭蛋币
    private Long waguCoins;
    // 活动扭蛋币
    private Long eventCoins;
    // 是否为管理员
    private Integer admin;
    // 用户登录凭证
    private String token;
}
