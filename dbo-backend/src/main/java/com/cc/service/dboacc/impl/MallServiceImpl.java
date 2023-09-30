package com.cc.service.dboacc.impl;

import com.cc.dto.MallOrderDTO;
import com.cc.dto.MallSignDTO;
import com.cc.entity.Mall;
import com.cc.entity.Purchaser;
import com.cc.mapper.dboacc.AccountMapper;
import com.cc.mapper.dboacc.MallMapper;
import com.cc.service.dboacc.IAccountService;
import com.cc.service.dboacc.IMallOrderService;
import com.cc.service.dboacc.IMallService;
import com.cc.service.dbochar.IMailService;
import com.cc.vo.Result;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

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
    public Result setSignRewardById(MallSignDTO mallSignDTO) {
        Integer integer = mallMapper.setSignRewardById(mallSignDTO);
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

    @Override
    public Result buyOrGiveMallPresent(Mall mall, Purchaser purchaser) {
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
}
