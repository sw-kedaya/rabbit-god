package com.cc.controller.dboacc;

import com.cc.service.dboacc.IActivityService;
import com.cc.vo.Result;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/activity")
public class ActivityController {
    @Resource
    private IActivityService activityService;

    @GetMapping("list")
    public Result list(){
        return Result.ok(activityService.getActivityList());
    }
}
