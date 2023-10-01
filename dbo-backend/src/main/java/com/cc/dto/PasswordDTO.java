package com.cc.dto;

import lombok.Data;

@Data
public class PasswordDTO {
    private String username;
    private String oldPassword;
    private String newPassword;
    private String confirmPassword;
    private String code;
    private String uuid;
}
