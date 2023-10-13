package com.cc.vo;

import lombok.Data;

@Data
public class MallVO {
    private Long id;
    private String name;
    private String description;
    private Long price;
    private Long count;
    private Long tblidx;
    private Long type;
    private Long sign_reward;
}
