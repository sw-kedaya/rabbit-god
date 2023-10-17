package com.cc.entity;

import lombok.Data;

@Data
public class WpShop {
    private Long id;
    private Integer serverChannelID;
    private Integer merchantTab;
    private Long idxItemTbl;
    private Integer dwPrice;
    private Integer dwMinPrice;
    private Integer dwInventory;
}
