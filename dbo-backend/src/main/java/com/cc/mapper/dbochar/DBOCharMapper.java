package com.cc.mapper.dbochar;

import com.cc.entity.DBOChar;

import java.util.List;

public interface DBOCharMapper {
    List<DBOChar> getDBOCharList(Long accountID);

    List<DBOChar> getAllCharNameList();
}
