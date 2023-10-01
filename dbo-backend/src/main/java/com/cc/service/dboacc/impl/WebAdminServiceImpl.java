package com.cc.service.dboacc.impl;

import com.cc.entity.WebAdmin;
import com.cc.mapper.dboacc.WebAdminMapper;
import com.cc.service.dboacc.IWebAdminService;
import com.cc.vo.Result;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class WebAdminServiceImpl implements IWebAdminService {
    @Resource
    private WebAdminMapper webAdminMapper;

    @Override
    public Result verifyAdmin(WebAdmin webAdmin) {
        WebAdmin user = webAdminMapper.verifyAdmin(webAdmin);
        if (user == null) return Result.fail("密码错误");
        return Result.ok();
    }
}
