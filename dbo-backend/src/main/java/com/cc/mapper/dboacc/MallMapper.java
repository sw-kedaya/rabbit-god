package com.cc.mapper.dboacc;

import com.cc.dto.MallSignDTO;
import com.cc.entity.Mall;
import com.cc.vo.MallVO;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface MallMapper {
    List<MallVO> getMallList();

    Integer saveMall(Mall mall);

    Integer updateMall(Mall mall);

    Integer deleteMallById(@PathVariable("id") Long id);

    Integer setSignRewardById(MallSignDTO mallSignDTO);

    Integer cancelSignRewardById(@PathVariable("id") Long id);

    List<MallVO> getAdminEnableMallList();

    List<Mall> getAdminAllMallList();

    Mall getMallById(@PathVariable("id") Long id);

    List<Mall> getSignRewardList(@PathVariable("signNum") Integer signNum);

    List<MallVO> getSignRewardListByList(List<Integer> list);

    List<MallVO> getSignRewardListByDay(@PathVariable("signNum") Integer signNum);
}
