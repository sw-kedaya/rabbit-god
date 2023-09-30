package com.cc.service.dboacc;

import com.cc.dto.MallOrderDTO;
import com.cc.entity.Mall;
import com.cc.entity.Purchaser;
import com.cc.vo.Result;

public interface IMallOrderService {
    void saveMallOrder(Mall mall, Purchaser purchaser, MallOrderDTO mallOrderDTO);

    Result getMallOrderByUserId(Long id);
}
