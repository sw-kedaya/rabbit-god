package com.cc.controller.dboacc;

import com.cc.service.dboacc.IEventService;
import com.cc.vo.Result;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/event")
public class EventController {
    @Resource
    private IEventService eventService;

    @GetMapping("list")
    public Result list(){
        return Result.ok(eventService.getEventList());
    }
}
