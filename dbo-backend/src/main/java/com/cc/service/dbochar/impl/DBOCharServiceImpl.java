package com.cc.service.dbochar.impl;

import com.cc.entity.DBOChar;
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
    public Result setSign(String charName, Long accountID) {
        // 获取当前时间
        Integer signNum = getSignNum();
        // 先判断该用户签到了没
        Result result = checkIsSign(accountID);
        if (!result.getSuccess()) return Result.fail("一个账号只能签到一次");
        // 记录签到
        Integer integer = dboCharMapper.setSign(charName, signNum);
        if (integer <= 0) return Result.fail("该角色今日已签到");
        // 发送奖励
        List<Mall> signRewardList = mallMapper.getSignRewardList(signNum);
        for (Mall mall : signRewardList) {
            mailService.generateSignMail(charName, mall.getTblidx(), mall.getCount());
        }
        return Result.ok();
    }

    @Override
    public Result checkIsSign(Long accountID) {
        // 获取当前时间
        Integer signNum = getSignNum();
        List<DBOChar> list = dboCharMapper.checkIsSign(accountID, signNum);
        if (list != null && !list.isEmpty()) return Result.fail("一个账号只能签到一次");
        return Result.ok();
    }

    private Integer getSignNum(){
        LocalDateTime now = LocalDateTime.now();
        int mouth = now.getMonthValue();
        int day = now.getDayOfMonth();
        return mouth * 100 + day;
    }
}
