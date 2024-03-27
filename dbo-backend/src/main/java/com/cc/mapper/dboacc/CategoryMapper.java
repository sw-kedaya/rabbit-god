package com.cc.mapper.dboacc;

import com.cc.entity.Category;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CategoryMapper {
    List<Category> getMallTypeList();

    Integer updateMallTypeById(Category category);

    Integer deleteById(@Param("id") Long id);

    Integer saveMallType(Category category);
}
