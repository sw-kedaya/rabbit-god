package com.cc.entity;

import lombok.Data;

/**
 * 这里的Mall是数据库的商品表(应为：Goods)
 */
@Data
public class Mall {
    private Long id;
    private String name;
    private String description;
    private Long price;
    private Long type;
    private Long del_flag;
    private Long tblidx;
    private Long place;
    private Long pos;
    private Long count;
    private Long rank;
    private Long durability;
    private Long grade;
    private Long needToIdentify;
    private Long battleAttribute;
    private String maker;
    private Long optionTblidx;
    private Long optionTblidx2;
    private Long optionRandomId;
    private Long optionRandomVal;
    private Long optionRandomId2;
    private Long optionRandomVal2;
    private Long optionRandomId3;
    private Long optionRandomVal3;
    private Long optionRandomId4;
    private Long optionRandomVal4;
    private Long optionRandomId5;
    private Long optionRandomVal5;
    private Long optionRandomId6;
    private Long optionRandomVal6;
    private Long optionRandomId7;
    private Long optionRandomVal7;
    private Long optionRandomId8;
    private Long optionRandomVal8;
    private Long useStartTime;
    private Long useEndTime;
    private Long restrictState;
    private Long durationType;
    /**是否为签到奖励*/
    private Long sign_reward;
}
