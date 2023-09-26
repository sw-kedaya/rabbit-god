package com.cc.service.dboacc;

import com.cc.entity.CashKey;
import com.cc.vo.Result;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface ICashKeyService {
    Result adminGetCashKeyList();

    Result adminAddCashKey(CashKey cashKey);

    Result useCdKey(CashKey cashKey);

    Result userOrder(String accountID);
}
