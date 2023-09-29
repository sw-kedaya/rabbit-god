package com.cc.service.dboacc;

import com.cc.entity.Mall;
import com.cc.vo.Result;

public interface IMallService {
    Result getMallList();

    Result saveMall(Mall mall);

    Result updateMall(Mall mall);

    Result deleteMallById(Long id);

    Result setSignRewardById(Long id);

    Result cancelSignRewardById(Long id);

    Result getAdminEnableMallList();

    Result getAdminAllMallList();
}
