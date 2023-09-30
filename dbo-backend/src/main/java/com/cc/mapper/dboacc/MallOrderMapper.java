package com.cc.mapper.dboacc;

import com.cc.entity.MallOrder;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface MallOrderMapper {
    void saveMallOrder(MallOrder mallOrder);

    List<MallOrder> getMallOrderByUserId(@PathVariable("id") Long id);
}
