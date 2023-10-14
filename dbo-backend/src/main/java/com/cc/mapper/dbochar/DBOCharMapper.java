package com.cc.mapper.dbochar;

import com.cc.entity.DBOChar;
import com.cc.vo.DBOCharVO;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface DBOCharMapper {
    List<DBOChar> getDBOCharList(Long accountID);

    List<DBOChar> getAllCharNameList();

    DBOChar getCharIDByCharName(@PathVariable("roleName") String roleName);

    Integer setSign(@PathVariable("charName") String charName, @PathVariable("signNum") Long signNum);

    List<DBOChar> checkIsSign(@PathVariable("accountID") Long accountID, @PathVariable("signNum") Long signNum);

    void resetSign();

    DBOChar getSignMessageByCharName(@PathVariable("roleName") String roleName);

    List<DBOChar> checkActivity(@PathVariable("accountID") Long accountID);

    Integer setIsGetCardById(@PathVariable("charID") Long charID);

    Integer setReplacementSign(@PathVariable("charName") String charName, @PathVariable("signNum") Long signNum);

    void resetIsGetCardById();

    List<DBOCharVO> getActivityTop();

    List<DBOCharVO> getMoneyTop();
}
