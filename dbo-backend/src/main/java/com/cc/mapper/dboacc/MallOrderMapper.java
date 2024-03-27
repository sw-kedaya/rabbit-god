package com.cc.mapper.dboacc;

import com.cc.entity.MallOrder;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MallOrderMapper {
    void saveMallOrder(MallOrder mallOrder);

    List<MallOrder> getMallOrderByUserId(@Param("id") Long id);
}
