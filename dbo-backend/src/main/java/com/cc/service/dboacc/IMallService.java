package com.cc.service.dboacc;

import com.cc.dto.MallSignDTO;
import com.cc.entity.Mall;
import com.cc.entity.Purchaser;
import com.cc.vo.Result;

public interface IMallService {
    Result getMallList();

    Result saveMall(Mall mall);

    Result updateMall(Mall mall);

    Result deleteMallById(Long id);

    Result setSignRewardById(MallSignDTO mallSignDTO);

    Result cancelSignRewardById(Long id);

    Result getAdminEnableMallList();

    Result getAdminAllMallList();

    Result buyOrGiveMallPresent(Mall mall, Purchaser purchaser);
}
