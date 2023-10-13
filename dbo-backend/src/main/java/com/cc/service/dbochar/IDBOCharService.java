package com.cc.service.dbochar;

import com.cc.vo.Result;

public interface IDBOCharService {
    Result getDBOCharList(Long accountID);

    Result setSign(String charName, Long accountID);

    Result checkIsSign(Long accountID);

    Result getSignMessage(String roleName);

    Result checkActivity(Long accountID);

    Result replacementSign(Long accountID, String roleName, Integer day, Long itemId, Long count);
}
