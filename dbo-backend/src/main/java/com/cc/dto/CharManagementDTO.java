package com.cc.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class CharManagementDTO {
    private Long charID;
    private String charName;
    private Long accountID;
    private Integer level;
    private Integer dboClass;
    private String dboClassName;
    private String guildName;
    private Long createTimeLong;
    private LocalDateTime createTime;
    private String IP;
    private Long money;
    private Long playTime;
    private Integer isOnline;
}
