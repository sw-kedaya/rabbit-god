package com.cc.quartz;

import com.cc.mapper.dboacc.AccountMapper;
import com.cc.mapper.dbochar.DBOCharMapper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

@Component
public class ReplacementCardSchedule {
    @Resource
    private AccountMapper accountMapper;
    @Resource
    private DBOCharMapper dboCharMapper;

    /**
     * 重置角色表的是否已获取过补签卡，用户表的：补签卡的数量、补签卡上限限制
     */
    @Scheduled(cron = "58 0 0 1 * ?")
    public void resetReplacementCard(){
        dboCharMapper.resetIsGetCardById();
        accountMapper.resetCardCount();
    }
}
