package com.cc.controller.dboacc;

import com.cc.entity.Category;
import com.cc.service.dboacc.IAccountService;
import com.cc.service.dboacc.ICategoryService;
import com.cc.vo.Result;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping(("/category"))
public class CategoryController {
    @Resource
    private ICategoryService categoryService;
    @Resource
    private IAccountService accountService;

    @GetMapping("/list")
    public Result getMallTypeList() {
        return categoryService.getMallTypeList();
    }

    @PostMapping("/admin/update")
    public Result updateMallTypeById(@RequestBody Category category) {
        if (!accountService.isAdmin(category.getUserId())) return Result.fail("禁止非管理员操作");
        return categoryService.updateMallTypeById(category);
    }

    @DeleteMapping("/admin/delete")
    public Result deleteById(Long id, Long userId) {
        if (!accountService.isAdmin(userId)) return Result.fail("禁止非管理员操作");
        return categoryService.deleteById(id);
    }

    @PostMapping("/admin/save")
    public Result saveMallType(@RequestBody Category category) {
        if (!accountService.isAdmin(category.getUserId())) return Result.fail("禁止非管理员操作");
        return categoryService.saveMallType(category);
    }
}
