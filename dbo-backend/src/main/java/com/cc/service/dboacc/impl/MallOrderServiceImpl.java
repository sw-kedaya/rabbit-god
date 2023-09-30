package com.cc.service.dboacc.impl;

import com.cc.dto.MallOrderDTO;
import com.cc.entity.Mall;
import com.cc.entity.MallOrder;
import com.cc.entity.Purchaser;
import com.cc.mapper.dboacc.MallOrderMapper;
import com.cc.service.dboacc.IMallOrderService;
import com.cc.vo.Result;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class MallOrderServiceImpl implements IMallOrderService {
    @Resource
    private MallOrderMapper mallOrderMapper;

    @Override
    public void saveMallOrder(Mall mall, Purchaser purchaser, MallOrderDTO mallOrderDTO) {
        MallOrder mallOrder = new MallOrder();
        mallOrder.setMallId(mall.getId());
        mallOrder.setMallName(mall.getName());
        mallOrder.setMallDesc(mall.getDescription());
        mallOrder.setPrice(mall.getPrice());
        mallOrder.setAccountID(purchaser.getAccountID());
        mallOrder.setCharName(purchaser.getRoleName());
        mallOrder.setCharID(mallOrderDTO.getCharId());
        mallOrder.setBuyTime(mallOrderDTO.getBuyTime());
        mallOrderMapper.saveMallOrder(mallOrder);
    }

    @Override
    public Result getMallOrderByUserId(Long id) {
        List<MallOrder> list = mallOrderMapper.getMallOrderByUserId(id);
        return Result.ok(list);
    }
}
