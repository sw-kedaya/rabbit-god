package com.cc.dto;

import lombok.Data;

@Data
public class AccountDTO {
    private Long accountID;
    private String username;
    private String password;
    private String rePassword;
    private String email;
    private String regIp;
    private String webIp;
    private String delCharPw;
    private String verification;
    private String UUID;
}
