package com.cc.service.dboacc.impl;

import com.cc.entity.Category;
import com.cc.mapper.dboacc.CategoryMapper;
import com.cc.service.dboacc.ICategoryService;
import com.cc.vo.Result;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class CategoryServiceImpl implements ICategoryService {
    @Resource
    private CategoryMapper categoryMapper;

    @Override
    public Result getMallTypeList() {
        return Result.ok(categoryMapper.getMallTypeList());
    }

    @Override
    public Result updateMallTypeById(Category category) {
        Integer integer = categoryMapper.updateMallTypeById(category);
        return integer > 0 ? Result.ok() : Result.fail("修改失败，请刷新并检查数据");
    }

    @Override
    public Result deleteById(Long id) {
        Integer integer = categoryMapper.deleteById(id);
        return integer > 0 ? Result.ok() : Result.fail("删除失败，请刷新并检查数据");
    }

    @Override
    public Result saveMallType(Category category) {
        Integer integer = categoryMapper.saveMallType(category);
        return integer > 0 ? Result.ok() : Result.fail("添加失败，请检查填写内容");
    }
}
