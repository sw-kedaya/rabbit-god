package com.cc.service.dbochar;

import com.cc.vo.Result;

public interface IDBOCharService {
    Result getDBOCharList(Long accountID);

    Result setSign(String charName, Long accountID);

    Result checkIsSign(Long accountID);

    Result getSignMessage(String roleName);
}
