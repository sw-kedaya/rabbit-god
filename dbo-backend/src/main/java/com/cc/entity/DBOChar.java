package com.cc.entity;

import lombok.Data;

@Data
public class DBOChar {
    // CharID-角色主键id
    private Integer charID;
    // CharName-角色主键名
    private String charName;
    // AccountID-用户id
    private Integer accountID;
    // Level-等级
    private Integer level;
    /**race-种族(0=人类 1= 那美克 2=魔人)*/
    private Integer race;
    /** Class-职业(
     * 0武道家 1 气功师 2工程师 3那美克战士
     * 4那美克龙族 5大魔人 6意魔人  7格斗
     * 8剑术 9鹤仙流 10龟仙流  13魔界
     * 14魔道 15天天 16博客  17 奥迪
     * 18葛兰  19普利珠 20卡尔)
     * */
    private Integer dboClass;
    /** Gender-性别(魔人/人类:男0，女1;那美克2)*/
    private Integer gender;
    // GuildName-流派
    private String guildName;
}
