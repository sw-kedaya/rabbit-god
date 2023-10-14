package com.cc.service.dbochar.impl;

import com.cc.entity.DBOChar;
import com.cc.entity.Mall;
import com.cc.mapper.dboacc.AccountMapper;
import com.cc.mapper.dboacc.MallMapper;
import com.cc.mapper.dbochar.DBOCharMapper;
import com.cc.service.dboacc.IAccountService;
import com.cc.service.dbochar.IDBOCharService;
import com.cc.service.dbochar.IMailService;
import com.cc.vo.MallVO;
import com.cc.vo.Result;
import com.cc.vo.SignMessage;
import org.apache.ibatis.logging.stdout.StdOutImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class DBOCharServiceImpl implements IDBOCharService {

    @Resource
    private DBOCharMapper dboCharMapper;
    @Resource
    private MallMapper mallMapper;
    @Resource
    private IMailService mailService;
    @Resource
    private IAccountService accountService;

    @Override
    public Result getDBOCharList(Long accountID) {
        return Result.ok(dboCharMapper.getDBOCharList(accountID));
    }

    @Override
    public Result setSign(String charName, Long accountID) {
        // 获取二进制时间
        Long binarySignNum = getBinarySignNum();
        // 先判断该用户签到了没
        Result result = checkIsSign(accountID);
        if (!result.getSuccess()) return Result.fail("一个账号只能签到一次");
        // 记录签到
        Integer integer = dboCharMapper.setSign(charName, binarySignNum);
        if (integer <= 0) return Result.fail("该角色今日已签到");
        // 发送奖励
        // 获取当前时间(日)
        Integer signNum = getSignNum();
        List<Mall> signRewardList = mallMapper.getSignRewardList(signNum);
        for (Mall mall : signRewardList) {
            mailService.generateSignMail(charName, mall.getTblidx(), mall.getCount());
        }
        return Result.ok();
    }

    @Override
    public Result checkIsSign(Long accountID) {
        // 获取二进制时间
        Long binarySignNum = getBinarySignNum();
        // 查询当前用户是否签到
        List<DBOChar> list = dboCharMapper.checkIsSign(accountID, binarySignNum);
        if (list != null && !list.isEmpty()) return Result.fail("一个账号只能签到一次");
        return Result.ok();
    }

    @Override
    public Result getSignMessage(String roleName) {
        DBOChar dboChar = dboCharMapper.getSignMessageByCharName(roleName);
        Long sign = dboChar.getSign();
        // 需要已签到、未签到的日期和对应的未签到的签到礼物信息
        // 已签到日期
        List<Integer> signed = new ArrayList<>();
        // 未签到日期
        List<Integer> notSigned = new ArrayList<>();
        for (int i = 0;; i++) {
            long isSigned = sign & 1;
            sign = sign >>> 1;
            if (i > LocalDate.now().getDayOfMonth()) break;
            if (isSigned == 1) {
                signed.add(i);
            } else if (i != 0){
                notSigned.add(i);
            }
        }
        SignMessage signMessage = new SignMessage();
        signMessage.setSigned(signed);
        signMessage.setNotSigned(notSigned);
        if (!notSigned.isEmpty()) {
            List<MallVO> mallList = mallMapper.getSignRewardListByList(notSigned);
            signMessage.setMallList(mallList);
        }
        return Result.ok(signMessage);
    }

    @Override
    public Result checkActivity(Long accountID) {
        List<DBOChar> list = dboCharMapper.checkActivity(accountID);
        // 判断该账户是否有活跃度超过2w且没发放过补签卡的角色
        // - 若无，则返回
        if (list == null || list.isEmpty()) return Result.ok();
        // - 若有，则发放并设置为已发放
        for (DBOChar dboChar : list) {
            Result result = accountService.checkCardCountLimit(accountID);
            if (!result.getSuccess()) return Result.ok();
            dboCharMapper.setIsGetCardById(dboChar.getCharID());
        }
        return Result.ok();
    }

    @Override
    public Result replacementSign(Long accountID, String roleName, Integer day,
                                  Long itemId, Long count) {
        // 扣减补签卡
        Result result = accountService.subCardCountById(accountID);
        if (!result.getSuccess()) return result;
        // 修改签到信息
        Long sign = getReplacementNum(day);
        Integer integer2 = dboCharMapper.setReplacementSign(roleName, sign);
        if (integer2 <= 0) return Result.fail("补签失败");
        // 发送补签的签到礼物
        if (itemId == -1 || count == -1) return Result.ok();
        mailService.generateReplacementSignMail(roleName, itemId, count);
        return Result.ok();
    }

    private Integer getSignNum() {
        return LocalDateTime.now().getDayOfMonth();
    }

    private Long getBinarySignNum() {
        LocalDateTime now = LocalDateTime.now();
        int day = now.getDayOfMonth();
        long result = 1L;
        result <<= day;
        return result;
    }

    private Long getReplacementNum(Integer day){
        return 1L << day;
    }
}
