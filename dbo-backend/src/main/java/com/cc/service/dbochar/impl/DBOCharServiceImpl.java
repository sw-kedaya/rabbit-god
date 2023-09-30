package com.cc.service.dbochar.impl;

import com.cc.entity.Mall;
import com.cc.mapper.dboacc.MallMapper;
import com.cc.mapper.dbochar.DBOCharMapper;
import com.cc.service.dbochar.IDBOCharService;
import com.cc.service.dbochar.IMailService;
import com.cc.vo.Result;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class DBOCharServiceImpl implements IDBOCharService {

    @Resource
    private DBOCharMapper dboCharMapper;
    @Resource
    private MallMapper mallMapper;
    @Resource
    private IMailService mailService;

    @Override
    public Result getDBOCharList(Long accountID) {
        return Result.ok(dboCharMapper.getDBOCharList(accountID));
    }

    @Override
    public Result setSign(String charName) {
        // 记录签到
        LocalDateTime now = LocalDateTime.now();
        int mouth = now.getMonthValue();
        int day = now.getDayOfMonth();
        int signNum = mouth * 100 + day;
        Integer integer = dboCharMapper.setSign(charName, signNum);
        if (integer <= 0) return Result.fail("该角色今日已签到");
        // 发送奖励
        List<Mall> signRewardList = mallMapper.getSignRewardList(signNum);
        for (Mall mall : signRewardList) {
            mailService.generateSignMail(charName, mall.getTblidx(), mall.getCount());
        }
        return Result.ok();
    }
}
