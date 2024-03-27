package com.cc.mapper.dboacc;

import com.cc.dto.MallSignDTO;
import com.cc.entity.Mall;
import com.cc.vo.MallVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MallMapper {
    List<MallVO> getMallList();

    Integer saveMall(Mall mall);

    Integer updateMall(Mall mall);

    Integer deleteMallById(@Param("id") Long id);

    Integer setSignRewardById(MallSignDTO mallSignDTO);

    Integer cancelSignRewardById(@Param("id") Long id);

    List<MallVO> getAdminEnableMallList();

    List<Mall> getAdminAllMallList();

    Mall getMallById(@Param("id") Long id);

    List<Mall> getSignRewardList(@Param("signNum") Integer signNum);

    List<MallVO> getSignRewardListByList(List<Integer> list);

    List<MallVO> getSignRewardListByDay(@Param("signNum") Integer signNum);
}
