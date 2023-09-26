package com.cc.entity;

import lombok.Data;

@Data
public class User {
    private Integer accountID;
    private String username;
    private String accStatus;
    private String email;
    // 余额
    private Integer mallPoints;
    // 现金扭蛋币
    private Integer waguCoins;
    // 活动扭蛋币
    private Integer eventCoins;
    // 是否为管理员
    private Integer admin;
    // 用户登录凭证
    private String token;
}
