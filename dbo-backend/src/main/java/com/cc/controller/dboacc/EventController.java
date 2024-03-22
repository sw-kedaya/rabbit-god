package com.cc.controller.dboacc;

import com.cc.entity.Event;
import com.cc.service.dboacc.IAccountService;
import com.cc.service.dboacc.IEventService;
import com.cc.util.ThreadLocalUtils;
import com.cc.vo.Result;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/event")
public class EventController {
    @Resource
    private IEventService eventService;
    @Resource
    private IAccountService accountService;

    @GetMapping("list")
    public Result list() {
        return Result.ok(eventService.getEventList());
    }

    @PostMapping("/admin/save")
    Result adminEventSave(@RequestBody Event event) {
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return eventService.adminEventSave(event);
    }

    @PutMapping("/admin/update")
    Result adminEventUpdate(@RequestBody Event event) {
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return eventService.adminEventUpdate(event);
    }

    @DeleteMapping("/admin/delete")
    Result adminEventDelete(Long id){
        if (!accountService.isAdmin(ThreadLocalUtils.getUserId())) return Result.fail("禁止非管理员操作");
        return eventService.adminEventDelete(id);
    }
}
