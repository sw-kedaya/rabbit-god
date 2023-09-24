package com.cc.service.impl;

import cn.hutool.json.JSONUtil;
import com.cc.entity.Activity;
import com.cc.entity.CommonConstant;
import com.cc.mapper.ActivityMapper;
import com.cc.service.IActivityService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Service
public class ActivityServiceImpl implements IActivityService {
    @Resource
    private ActivityMapper activityMapper;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @Override
    public List<Activity> getActivityList() {
        // 考虑到活动表的频繁查询，所以将它缓存到redis,TTL为1小时
        String json = redisTemplate.opsForValue().get(CommonConstant.ACTIVITY_KEY);
        if (json != null && !json.isEmpty()) return JSONUtil.toList(json, Activity.class);
        List<Activity> list = activityMapper.getActivityList();
        redisTemplate.opsForValue().set(CommonConstant.ACTIVITY_KEY, JSONUtil.toJsonStr(list)
                ,CommonConstant.ACTIVITY_TTL_HOURS, TimeUnit.HOURS);
        return list;
    }
}
