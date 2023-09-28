package com.cc.service.dboacc.impl;

import cn.hutool.core.bean.BeanUtil;
import com.cc.dto.CashKeyDTO;
import com.cc.entity.CashKey;
import com.cc.entity.DBOChar;
import com.cc.mapper.dboacc.AccountMapper;
import com.cc.mapper.dboacc.CashKeyMapper;
import com.cc.mapper.dbochar.DBOCharMapper;
import com.cc.service.dboacc.ICashKeyService;
import com.cc.util.CashKeyUtils;
import com.cc.vo.Result;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
public class CashKeyServiceImpl implements ICashKeyService {
    @Resource
    private CashKeyMapper cashKeyMapper;

    @Resource
    private AccountMapper accountMapper;

    @Resource
    private DBOCharMapper dboCharMapper;

    @Autowired
    @Qualifier("dboAccSqlSessionFactory")
    private SqlSessionFactory sqlSessionFactory;

    @Override
    public Result adminGetCashKeyList() {
        List<CashKey> cashKeys = cashKeyMapper.adminGetCashKeyList();
        List<DBOChar> charNameList = dboCharMapper.getAllCharNameList();
        List<CashKeyDTO> list = new ArrayList<>();
        for (CashKey cashKey : cashKeys) {
            CashKeyDTO cashKeyDTO = BeanUtil.copyProperties(cashKey, CashKeyDTO.class);
            for (DBOChar dboChar : charNameList) {
                if (Objects.equals(dboChar.getAccountID(), cashKeyDTO.getAccountID())) {
                    cashKeyDTO.setRoleName(dboChar.getCharName());
                    break;
                }
            }
            list.add(cashKeyDTO);
        }
        return Result.ok(list);
    }

    @Override
    public Result adminAddCashKey(Long cash, Long num) {
        SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH);
        CashKeyMapper mapper = sqlSession.getMapper(CashKeyMapper.class);
        try {
            for (int i = 0; i < num; i++) {
                String key = CashKeyUtils.generateKey();
                CashKey cashKey = new CashKey();
                cashKey.setCdKey(key);
                cashKey.setCash(cash);
                mapper.adminAddCashKey(cashKey);
            }
            sqlSession.commit();
        } catch (Exception e) {
            sqlSession.rollback();
            throw new RuntimeException(e);
        } finally {
            sqlSession.close();
        }
        return Result.ok();
    }

    @Override
    public Result deleteAllKey() {
        cashKeyMapper.deleteAllKey();
        return Result.ok();
    }

    @Transactional("dboAccTransactionManager")
    @Override
    public Result useCdKey(CashKey cashKey) {
        System.out.println(cashKey);
        // 先根据卡密取出c点值，若c点为0则为异常卡密
        Long cash = cashKeyMapper.checkCdKey(cashKey.getCdKey());
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
