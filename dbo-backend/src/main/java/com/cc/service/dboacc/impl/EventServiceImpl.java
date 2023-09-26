package com.cc.service.dboacc.impl;

import cn.hutool.json.JSONUtil;
import com.cc.entity.Event;
import com.cc.entity.CommonConstant;
import com.cc.mapper.dboacc.EventMapper;
import com.cc.service.dboacc.IEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Service
public class EventServiceImpl implements IEventService {
    @Resource
    private EventMapper eventMapper;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @Override
    public List<Event> getEventList() {
        // 考虑到活动表的频繁查询，所以将它缓存到redis,TTL为1小时
        String json = redisTemplate.opsForValue().get(CommonConstant.Event_KEY);
        if (json != null && !json.isEmpty()) return JSONUtil.toList(json, Event.class);
        List<Event> list = eventMapper.getEventList();
        redisTemplate.opsForValue().set(CommonConstant.Event_KEY, JSONUtil.toJsonStr(list)
                ,CommonConstant.Event_TTL_HOURS, TimeUnit.HOURS);
        return list;
    }
}
