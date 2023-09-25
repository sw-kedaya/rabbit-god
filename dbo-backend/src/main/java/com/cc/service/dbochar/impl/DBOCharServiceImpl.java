package com.cc.service.dbochar.impl;

import com.cc.mapper.dbochar.DBOCharMapper;
import com.cc.service.dbochar.IDBOCharService;
import com.cc.vo.Result;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class DBOCharServiceImpl implements IDBOCharService {

    @Resource
    private DBOCharMapper dboCharMapper;

    @Override
    public Result getDBOCharList(Integer accountID) {
        return Result.ok(dboCharMapper.getDBOCharList(accountID));
    }
}
