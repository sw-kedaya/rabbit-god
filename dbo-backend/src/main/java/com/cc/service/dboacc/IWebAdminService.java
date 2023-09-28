package com.cc.service.dboacc;

import com.cc.entity.WebAdmin;
import com.cc.vo.Result;

public interface IWebAdminService {
    Result verifyAdmin(WebAdmin webAdmin);
}
