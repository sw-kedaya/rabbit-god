package com.cc.mapper;

import com.cc.entity.Category;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

public interface CategoryMapper {
    List<Category> getHeadList();
}
