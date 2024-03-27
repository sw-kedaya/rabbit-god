package com.cc.mapper.dbochar;

import com.cc.dto.CharManagementDTO;
import com.cc.entity.DBOChar;
import com.cc.vo.DBOCharVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DBOCharMapper {
    List<DBOChar> getDBOCharList(Long accountID);

    List<DBOChar> getAllCharNameList();

    DBOChar getCharIDByCharName(@Param("roleName") String roleName);

    Integer setSign(@Param("charName") String charName, @Param("signNum") Long signNum);

    List<DBOChar> checkIsSign(@Param("accountID") Long accountID, @Param("signNum") Long signNum);

    void resetSign();

    DBOChar getSignMessageByCharName(@Param("roleName") String roleName);

    List<DBOChar> checkActivity(@Param("accountID") Long accountID);

    Integer setIsGetCardById(@Param("charID") Long charID);

    Integer setReplacementSign(@Param("charName") String charName, @Param("signNum") Long signNum);

    void resetIsGetCardById();

    List<DBOCharVO> getActivityTop();

    List<DBOCharVO> getMoneyTop();

    List<CharManagementDTO> adminGetCharacterList();

    Integer adminUpdateCharacter(CharManagementDTO dto);

    String getCharNameByID(@Param("id") Long id);
}
