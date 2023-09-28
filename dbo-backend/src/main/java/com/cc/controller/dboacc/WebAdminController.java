package com.cc.controller.dboacc;

import com.cc.entity.WebAdmin;
import com.cc.service.dboacc.IWebAdminService;
import com.cc.vo.Result;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/web")
public class WebAdminController {
    @Resource
    private IWebAdminService webAdminService;

    @PostMapping("/admin/verify")
    private Result verifyWebAdmin(@RequestBody WebAdmin webAdmin){
        return webAdminService.verifyAdmin(webAdmin);
    }
}
