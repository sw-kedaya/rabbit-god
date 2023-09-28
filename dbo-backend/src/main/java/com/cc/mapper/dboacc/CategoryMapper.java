package com.cc.mapper.dboacc;

import com.cc.entity.Category;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface CategoryMapper {
    List<Category> getMallTypeList();

    Integer updateMallTypeById(Category category);

    Integer deleteById(@PathVariable("id") Long id);

    Integer saveMallType(Category category);
}
