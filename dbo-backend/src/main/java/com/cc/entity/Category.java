package com.cc.entity;

import lombok.Data;

/**
 * 此分类为商城分类(mall_type)
 */
@Data
public class Category {
    private Long userId;
    private Long id;
    private String name;
    private Long sort;
}
