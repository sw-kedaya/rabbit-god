package com.cc.mapper.dboacc;

import com.cc.entity.Mall;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface MallMapper {
    List<Mall> getMallList();

    Integer saveMall(Mall mall);

    Integer updateMall(Mall mall);

    Integer deleteMallById(@PathVariable("id") Long id);

    Integer setSignRewardById(@PathVariable("id") Long id);

    Integer cancelSignRewardById(@PathVariable("id") Long id);

    List<Mall> getAdminEnableMallList();

    List<Mall> getAdminAllMallList();
}
