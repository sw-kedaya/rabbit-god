package com.cc.mapper.dboacc;

import com.cc.entity.CashKey;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface CashKeyMapper {
    List<CashKey> adminGetCashKeyList();

    void adminAddCashKey(CashKey cashKey);

    Integer checkCdKey(@PathVariable("cdKey") String cdKey);

    Integer useCdKey(CashKey cashKey);

    List<CashKey> userOrder(@PathVariable("accountID") String accountID);
}
