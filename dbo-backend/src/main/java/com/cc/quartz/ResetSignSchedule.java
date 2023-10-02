//package com.cc.quartz;
//
//import com.cc.mapper.dbochar.DBOCharMapper;
//import org.springframework.scheduling.annotation.Scheduled;
//import org.springframework.stereotype.Component;
//
//import javax.annotation.Resource;
//
//@Component
//public class ResetSignSchedule {
//    @Resource
//    private DBOCharMapper dboCharMapper;
//
//    @Scheduled(cron = "0 0 0 1 * ?")
//    public void resetSign() {
//        dboCharMapper.resetSign();
//    }
//}
