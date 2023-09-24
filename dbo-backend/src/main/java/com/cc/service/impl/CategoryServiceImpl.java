package com.cc.service.impl;

import com.cc.entity.Category;
import com.cc.mapper.CategoryMapper;
import com.cc.service.ICategoryService;
import com.cc.vo.Result;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CategoryServiceImpl implements ICategoryService {
    @Resource
    private CategoryMapper categoryMapper;

    @Override
    public List<Category> getHeadList() {
        return categoryMapper.getHeadList();
    }
}
