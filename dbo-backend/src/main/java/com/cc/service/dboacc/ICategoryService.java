package com.cc.service.dboacc;

import com.cc.entity.Category;
import com.cc.vo.Result;

public interface ICategoryService {
    Result getMallTypeList();

    Result updateMallTypeById(Category category);

    Result deleteById(Long id);

    Result saveMallType(Category category);
}
