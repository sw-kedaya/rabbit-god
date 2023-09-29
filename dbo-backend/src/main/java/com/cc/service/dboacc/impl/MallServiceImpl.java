package com.cc.service.dboacc.impl;

import com.cc.entity.Mall;
import com.cc.mapper.dboacc.MallMapper;
import com.cc.service.dboacc.IMallService;
import com.cc.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class MallServiceImpl implements IMallService {
    @Resource
    private MallMapper mallMapper;

    @Override
    public Result getMallList() {
        return Result.ok(mallMapper.getMallList());
    }

    @Override
    public Result saveMall(Mall mall) {
        Integer integer = mallMapper.saveMall(mall);
        return integer > 0 ? Result.ok() : Result.fail("添加失败，请检查是否有错误数据");
    }

    @Override
    public Result updateMall(Mall mall) {
        Integer integer = mallMapper.updateMall(mall);
        return integer > 0 ? Result.ok() : Result.fail("修改失败，请检查是否有错误数据");
    }

    @Override
    public Result deleteMallById(Long id) {
        Integer integer = mallMapper.deleteMallById(id);
        return integer > 0 ? Result.ok() : Result.fail("删除失败，请刷新后检查数据");
    }

    @Override
    public Result setSignRewardById(Long id) {
        Integer integer = mallMapper.setSignRewardById(id);
        return integer > 0 ? Result.ok() : Result.fail("设置失败，请刷新后检查数据");
    }

    @Override
    public Result cancelSignRewardById(Long id) {
        Integer integer = mallMapper.cancelSignRewardById(id);
        return integer > 0 ? Result.ok() : Result.fail("设置失败，请刷新后检查数据");
    }

    @Override
    public Result getAdminEnableMallList() {
        return Result.ok(mallMapper.getAdminEnableMallList());
    }

    @Override
    public Result getAdminAllMallList() {
        return Result.ok(mallMapper.getAdminAllMallList());
    }
}
