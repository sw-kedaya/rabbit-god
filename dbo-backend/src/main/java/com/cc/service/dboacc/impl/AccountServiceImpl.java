package com.cc.service.dboacc.impl;

import com.cc.config.LoginCodeConfiguration;
import com.cc.config.RegisterConfiguration;
import com.cc.dto.AccountDTO;
import com.cc.dto.AccountManagementDTO;
import com.cc.dto.PasswordDTO;
import com.cc.entity.Account;
import com.cc.entity.CommonConstant;
import com.cc.entity.User;
import com.cc.mapper.dboacc.AccountMapper;
import com.cc.service.dboacc.IAccountService;
import com.cc.service.dboacc.ISendMailService;
import com.cc.util.JwtUtils;
import com.cc.vo.Result;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.concurrent.TimeUnit;

@Service
public class AccountServiceImpl implements IAccountService {
    @Resource
    private AccountMapper accountMapper;
    @Autowired
    private StringRedisTemplate redisTemplate;
    @Resource
    private RegisterConfiguration registerConfiguration;
    @Resource
    private ISendMailService sendMailService;
    @Resource
    private LoginCodeConfiguration loginCodeConfiguration;

    @Override
    public Result register(AccountDTO accountDTO, HttpServletRequest request) {
        // 判断是否开放注册与是否开启邮箱验证码验证
        if (!registerConfiguration.getOpen()) return Result.fail("注册功能未开放");
        if (registerConfiguration.getEmailCheck()) {
            // 判断是否验证码是否一致
            String code = redisTemplate.opsForValue().get(CommonConstant.CODE_KEY + accountDTO.getUUID());
            if (code == null || code.isEmpty()) return Result.fail("验证码错误");
            if (!code.equals(accountDTO.getVerification())) return Result.fail("验证码错误");
            redisTemplate.delete(CommonConstant.CODE_KEY + accountDTO.getUUID());
        }
        // 判断该邮箱和ip是否超出指定次数
        Integer emailNum = accountMapper.checkEmailNum(accountDTO.getEmail());
        if (emailNum >= registerConfiguration.getEmailMaxNum()) return Result.fail("该邮箱注册已达上限");
        Integer ipNum = accountMapper.checkIpNum(request.getRemoteAddr());
        if (ipNum >= registerConfiguration.getIpMaxNum()) return Result.fail("该ip注册已达上限");
        // 存入前判断用户是否存在
        Account userRepeat = accountMapper.isUserRepeat(accountDTO.getUsername());
        if (userRepeat != null && userRepeat.getUsername().equals(accountDTO.getUsername())) {
            return Result.fail("用户已存在");
        }
        // 存入数据库
        accountDTO.setWebIp(request.getRemoteAddr());
        accountDTO.setRegIp(request.getRemoteAddr());
        accountDTO.setDelCharPw(DigestUtils.md5DigestAsHex(accountDTO.getPassword().getBytes()));
        Account account = new Account();
        BeanUtils.copyProperties(accountDTO, account);
        accountMapper.register(account);
        return Result.ok();
    }

    @Override
    public Result login(AccountDTO accountDTO) {
        // 先判断验证码是否正确
        if (loginCodeConfiguration.getOpen()) {
            String uuid = accountDTO.getUUID();
            String code = accountDTO.getCode();
            if (uuid == null || code == null || uuid.isEmpty() || code.isEmpty()) return Result.fail("验证码错误");
            String key = CommonConstant.LOGIN_CODE_KEY + uuid;
            String redisCode = redisTemplate.opsForValue().get(key);
            if (!code.equalsIgnoreCase(redisCode)) return Result.fail("验证码错误");
            redisTemplate.delete(key);
        }
        Account account = new Account();
        BeanUtils.copyProperties(accountDTO, account);
        Account userAccount = accountMapper.checkUserPwd(account);
        if (userAccount == null || !account.getUsername().equals(userAccount.getUsername())) {
            // 用户不存在或密码错误
            return Result.fail("请检查用户名与密码");
        }
        User user = new User();
        BeanUtils.copyProperties(userAccount, user);
        String token = JwtUtils.generatorToken(user.getUsername());
        redisTemplate.opsForValue().set(token, user.getAccountID().toString(), CommonConstant.TOKEN_TTL, TimeUnit.SECONDS);
        user.setToken(token);
        return Result.ok(user);
    }

    @Override
    public Result logout(String token) {
        return Boolean.TRUE.equals(redisTemplate.delete(token)) ? Result.ok() : Result.fail("账号已经登出。");
    }

    @Override
    public Result forgetPassword(String username) {
        Account account = accountMapper.getPassword(username);
        sendMailService.sendMailForForget(account.getEmail(), account.getPassword());
        return Result.ok();
    }

    @Override
    public Result updatePwd(PasswordDTO passwordDTO) {
        // 判断验证码
        if (registerConfiguration.getEmailCheck()) {
            String code = redisTemplate.opsForValue().get(CommonConstant.CODE_KEY + passwordDTO.getUuid());
            if (code == null || code.isEmpty()) return Result.fail("验证码错误");
            if (!code.equals(passwordDTO.getCode())) return Result.fail("验证码错误");
            redisTemplate.delete(CommonConstant.CODE_KEY + passwordDTO.getUuid());
        }
        // 验证码通过则修改
        Account account = accountMapper.getPassword(passwordDTO.getUsername());
        if (!passwordDTO.getOldPassword().equals(account.getPassword())) return Result.fail("修改失败，请检查原密码");
        return accountMapper.updatePwd(passwordDTO.getNewPassword(), passwordDTO.getUsername(),
                DigestUtils.md5DigestAsHex(passwordDTO.getNewPassword().getBytes())) > 0 ?
                Result.ok() : Result.fail("修改失败，请检查密码");
    }

    @Override
    public boolean isAdmin(Long id) {
        Integer admin = accountMapper.isAdmin(id);
        return admin == 1;
    }

    @Override
    public boolean checkUserCashById(Long id, Long price) {
        Integer enough = accountMapper.checkUserCashById(id, price);
        return enough > 0;
    }

    @Override
    public Result getLatestMallPoints(Long id) {
        Account account = accountMapper.getLatestMallPoints(id);
        if (account == null) return Result.fail("刷新出错了");
        return Result.ok(account);
    }

    @Override
    public Result getCardCount(Long id) {
        return Result.ok(accountMapper.getCardCount(id).getReplacementCard());
    }

    @Override
    public Result subCardCountById(Long accountID) {
        Integer integer = accountMapper.subCardCountById(accountID);
        return integer <= 0 ? Result.fail("补签卡不足") : Result.ok();
    }


    @Transactional("dboAccTransactionManager")
    @Override
    public Result checkCardCountLimit(Long accountID) {
        Integer integer1 = accountMapper.addCardCountById(accountID);
        Integer integer = accountMapper.addCardCountLimit(accountID);
        if (integer <= 0 || integer1 <= 0) return Result.fail("每个账户最多获取三张补签卡");
        return Result.ok();
    }

    @Override
    public boolean isBlock(Long accountID) {
        return accountMapper.isBlock(accountID) > 0;
    }

    @Override
    public Result adminGetList() {
        return Result.ok(accountMapper.adminGetList());
    }

    @Override
    public Result adminUpdateBalance(AccountManagementDTO accountManagementDTO) {
        return accountMapper.adminUpdateBalance(accountManagementDTO) > 0 ? Result.ok() : Result.fail("编辑错误，请查看源码");
    }

    @Override
    public Result blockedAccount(Long id) {
        return accountMapper.blockedAccount(id) > 0 ? Result.ok() : Result.fail("封禁错误，请查看源码");
    }

    @Override
    public Result unblockedAccount(Long id) {
        return accountMapper.unblockedAccount(id) > 0 ? Result.ok() : Result.fail("解封错误，请查看源码");
    }

    @Override
    public boolean isAuctionPointEnoughById(Long userId, Long price) {
        return accountMapper.isAuctionPointEnoughById(userId, price) > 0;
    }

    @Override
    public Integer returnAuctionPrice(Long accountID, Long currentPrice) {
        return accountMapper.returnAuctionPrice(accountID, currentPrice);
    }
}
