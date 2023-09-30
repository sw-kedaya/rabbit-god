package com.cc.dto;

import com.cc.entity.Mall;
import com.cc.entity.Purchaser;
import lombok.Data;

@Data
public class MallAndPurchaserDTO {
    private Mall mall;
    private Purchaser purchaser;
}
