package com.cc.mapper.dboacc;

import com.cc.entity.CashKey;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CashKeyMapper {
    List<CashKey> adminGetCashKeyList();

    void adminAddCashKey(CashKey cashKey);

    void deleteAllKey();

    Long checkCdKey(@Param("cdKey") String cdKey);

    Integer useCdKey(CashKey cashKey);

    List<CashKey> userOrder(@Param("accountID") String accountID);
}
