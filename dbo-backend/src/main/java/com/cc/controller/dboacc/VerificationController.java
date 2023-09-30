package com.cc.controller.dboacc;

import com.cc.config.RegisterConfiguration;
import com.cc.entity.CommonConstant;
import com.cc.service.dboacc.ISendMailService;
import com.cc.vo.CodeMessage;
import com.cc.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.Random;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/code")
public class VerificationController {
    @Autowired
    private StringRedisTemplate redisTemplate;
    @Resource
    private RegisterConfiguration registerConfiguration;
    @Resource
    private ISendMailService sendMailService;

    @GetMapping("send")
    public Result getCode(String email) {
        if (!registerConfiguration.getEmailCheck()) return Result.fail("未开启邮箱验证");
        // 随机生成六位
        Random random = new Random();
        String code = String.valueOf(100000 + random.nextInt(900000));
        String uuid = UUID.randomUUID().toString().replace("-", "");
        // 验证码存储到redis，并设置5分钟过期时间
        redisTemplate.opsForValue().set(CommonConstant.CODE_KEY + uuid, code, 5, TimeUnit.MINUTES);
        // 发送邮件
        sendMailService.sendMailForRegister(email,code);
        // 把uuid发送到前端
        CodeMessage codeMessage = new CodeMessage();
        codeMessage.setUuid(uuid);
        return Result.ok(codeMessage);
    }

    @GetMapping("check")
    public Result checkOpen(){
        return Result.ok(registerConfiguration.getEmailCheck());
    }
}
