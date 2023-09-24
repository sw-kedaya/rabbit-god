package com.cc.controller.dbochar;

import com.cc.service.dbochar.IDBOCharService;
import com.cc.vo.Result;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/char")
public class DBOCharController {

    @Resource
    private IDBOCharService dboCharService;

    @GetMapping("/list")
    public Result getDBOCharList(){
        return dboCharService.getDBOCharList();
    }
}
