package com.cc.service.dboacc.impl;

import cn.hutool.json.JSONUtil;
import com.cc.dto.MallOrderDTO;
import com.cc.dto.MallSignDTO;
import com.cc.entity.CommonConstant;
import com.cc.entity.Mall;
import com.cc.entity.Purchaser;
import com.cc.mapper.dboacc.AccountMapper;
import com.cc.mapper.dboacc.MallMapper;
import com.cc.service.dboacc.IAccountService;
import com.cc.service.dboacc.IMallOrderService;
import com.cc.service.dboacc.IMallService;
import com.cc.service.dbochar.IMailService;
import com.cc.vo.MallVO;
import com.cc.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Service
public class MallServiceImpl implements IMallService {
    @Resource
    private MallMapper mallMapper;
    @Resource
    private IAccountService accountService;
    @Resource
    private IMailService mailService;
    @Resource
    private IMallOrderService mallOrderService;
    @Autowired
    private StringRedisTemplate redisTemplate;

    @Override
    public Result getMallList() {
        String json = redisTemplate.opsForValue().get(CommonConstant.MALL_LIST_USER_KEY);
        if (json != null && !json.isEmpty()) return Result.ok(JSONUtil.toList(json, MallVO.class));
        List<MallVO> mallList = mallMapper.getMallList();
        redisTemplate.opsForValue().set(CommonConstant.MALL_LIST_USER_KEY, JSONUtil.toJsonStr(mallList),
                CommonConstant.MALL_LIST_TTL_HOURS, TimeUnit.HOURS);
        return Result.ok(mallList);
    }

    @Override
    public Result saveMall(Mall mall) {
        Integer integer = mallMapper.saveMall(mall);
        if (integer <= 0) return Result.fail("添加失败，请检查是否有错误数据");
        deleteAllMallKey();
        return Result.ok();
    }

    @Override
    public Result updateMall(Mall mall) {
        Integer integer = mallMapper.updateMall(mall);
        if (integer <= 0) return Result.fail("修改失败，请检查是否有错误数据");
        deleteAllMallKey();
        return Result.ok();
    }

    @Override
    public Result deleteMallById(Long id) {
        Integer integer = mallMapper.deleteMallById(id);
        if (integer <= 0) return Result.fail("删除失败，请刷新后检查数据");
        deleteAllMallKey();
        return Result.ok();
    }

    @Override
    public Result setSignRewardById(MallSignDTO mallSignDTO) {
        Integer integer = mallMapper.setSignRewardById(mallSignDTO);
        if (integer <= 0) return Result.fail("设置失败，请刷新后检查数据");
        deleteAllMallKey();
        return Result.ok();
    }

    @Override
    public Result cancelSignRewardById(Long id) {
        Integer integer = mallMapper.cancelSignRewardById(id);
        if (integer <= 0) return Result.fail("设置失败，请刷新后检查数据");
        deleteAllMallKey();
        return Result.ok();
    }

    @Override
    public Result getAdminEnableMallList() {
        String json = redisTemplate.opsForValue().get(CommonConstant.MALL_LIST_ADMIN_KEY);
        if (json != null && !json.isEmpty()) return Result.ok(JSONUtil.toList(json, MallVO.class));
        List<MallVO> mallList = mallMapper.getAdminEnableMallList();
        redisTemplate.opsForValue().set(CommonConstant.MALL_LIST_ADMIN_KEY, JSONUtil.toJsonStr(mallList),
                CommonConstant.MALL_LIST_TTL_HOURS, TimeUnit.HOURS);
        return Result.ok(mallList);
    }

    @Override
    public Result getAdminAllMallList() {
        String json = redisTemplate.opsForValue().get(CommonConstant.MALL_LIST_ADMIN_CRUD_KEY);
        if (json != null && !json.isEmpty()) return Result.ok(JSONUtil.toList(json, Mall.class));
        List<Mall> mallList = mallMapper.getAdminAllMallList();
        redisTemplate.opsForValue().set(CommonConstant.MALL_LIST_ADMIN_CRUD_KEY, JSONUtil.toJsonStr(mallList),
                CommonConstant.MALL_LIST_TTL_HOURS, TimeUnit.HOURS);
        return Result.ok(mallList);
    }

    @Override
    public Result buyOrGiveMallPresent(Mall mall, Purchaser purchaser) {
        // 新增：禁止封禁账号购买/赠送
        if(accountService.isBlock(purchaser.getAccountID())) return Result.fail("禁止封禁账号购买物品！");
        // 判断用户余额是否足够：足够-扣减(内部自动)，不足够-返回
        boolean enough;
        try {
            enough = accountService.checkUserCashById(purchaser.getAccountID(), mall.getPrice());
        } catch (DataIntegrityViolationException e) {
            return Result.fail("余额不足");
        }
        if (!enough) return Result.fail("余额不足");
        // 生成邮件表
        MallOrderDTO mallOrderDTO = mailService.generateMail(purchaser.getRoleName(), mall.getTblidx(), mall.getCount());
        if (mallOrderDTO == null) return Result.fail("请检查角色名是否存在");
        // 生成订单
        mallOrderService.saveMallOrder(mall, purchaser, mallOrderDTO);
        return Result.ok();
    }

    @Override
    public Result getCurrentSignRewardMessage() {
        int day = LocalDateTime.now().getDayOfMonth();
        List<MallVO> list = mallMapper.getSignRewardListByDay(day);
        if (list == null || list.isEmpty()) return Result.fail("无");
        StringBuilder message = new StringBuilder("[");
        for (MallVO mallVO : list) {
            message.append(mallVO.getName()).append(", ");
        }
        message.delete(message.length() - 2, message.length());
        message.append("]");
        return Result.ok(message);
    }

    private void deleteAllMallKey() {
        redisTemplate.delete(CommonConstant.MALL_LIST_USER_KEY);
        redisTemplate.delete(CommonConstant.MALL_LIST_ADMIN_KEY);
        redisTemplate.delete(CommonConstant.MALL_LIST_ADMIN_CRUD_KEY);
    }
}
