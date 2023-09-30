package com.cc.mapper.dbochar;

import com.cc.entity.DBOChar;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface DBOCharMapper {
    List<DBOChar> getDBOCharList(Long accountID);

    List<DBOChar> getAllCharNameList();

    DBOChar getCharIDByCharName(@PathVariable("roleName") String roleName);

    Integer setSign(@PathVariable("charName") String charName, @PathVariable("signNum") Integer signNum);
}
