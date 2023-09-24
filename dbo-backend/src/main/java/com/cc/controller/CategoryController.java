package com.cc.controller;

import com.cc.service.ICategoryService;
import com.cc.vo.Result;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/category")
public class CategoryController {
    @Resource
    private ICategoryService categoryService;

    @GetMapping("head")
    public Result getHeadList(){
        return Result.ok(categoryService.getHeadList());
    }
}
