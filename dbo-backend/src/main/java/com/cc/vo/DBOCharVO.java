package com.cc.vo;

import lombok.Data;

@Data
public class DBOCharVO {
    private String charName;
    private Integer level;
    private Integer dboClass;
    private String guildName;
    private Long activity;
    private Long money;
    /** 该属性不参与数据库 */
    private Integer rank;
    private String dboClassName;
}
