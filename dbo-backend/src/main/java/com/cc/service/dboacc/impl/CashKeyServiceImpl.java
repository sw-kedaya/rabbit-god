package com.cc.service.dboacc.impl;

import com.cc.entity.CashKey;
import com.cc.mapper.dboacc.AccountMapper;
import com.cc.mapper.dboacc.CashKeyMapper;
import com.cc.service.dboacc.ICashKeyService;
import com.cc.vo.Result;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class CashKeyServiceImpl implements ICashKeyService {
    @Resource
    private CashKeyMapper cashKeyMapper;

    @Resource
    private AccountMapper accountMapper;

    @Override
    public Result adminGetCashKeyList() {
        return null;
    }

    @Override
    public Result adminAddCashKey(CashKey cashKey) {
        return null;
    }

    @Transactional("dboAccTransactionManager")
    @Override
    public Result useCdKey(CashKey cashKey) {
        System.out.println(cashKey);
        // 先根据卡密取出c点值，若c点为0则为异常卡密
        Integer cash = cashKeyMapper.checkCdKey(cashKey.getCdKey());
        if (cash <= 0) return Result.fail("卡密不存在或已失效");
        // 若c点为有效值，设置已使用
        cashKey.setUseTime(LocalDateTime.now());
        Integer count = cashKeyMapper.useCdKey(cashKey);
        if (count <= 0) return Result.fail("卡密不存在或已失效");
        // 然后给对应的账户增加c点
        Integer result = accountMapper.addMallPoints(cashKey.getAccountID(), cash);
        if (result <= 0) return Result.fail("卡密不存在或已失效");
        return Result.ok("兑换成功");
    }

    @Override
    public Result userOrder(String accountID) {
        List<CashKey> cashKeys = cashKeyMapper.userOrder(accountID);
        return Result.ok(cashKeys);
    }
}
