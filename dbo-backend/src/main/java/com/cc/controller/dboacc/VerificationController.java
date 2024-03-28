package com.cc.controller.dboacc;

import cn.hutool.core.codec.Base64;
import com.cc.config.LoginCodeConfiguration;
import com.cc.config.RegisterConfiguration;
import com.cc.entity.CommonConstant;
import com.cc.service.dboacc.ISendMailService;
import com.cc.vo.CodeMessage;
import com.cc.vo.Result;
import com.google.code.kaptcha.Producer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.util.FastByteArrayOutputStream;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
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

    @Resource(name = "captchaProducer")
    private Producer captchaProducer;
    @Resource(name = "captchaProducerMath")
    private Producer captchaProducerMath;
    @Resource
    private LoginCodeConfiguration loginCodeConfiguration;

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
        System.out.println("验证码：" + code);
        // 把uuid发送到前端
        CodeMessage codeMessage = new CodeMessage();
        codeMessage.setUuid(uuid);
        return Result.ok(codeMessage);
    }

    @GetMapping("check")
    public Result checkOpen(){
        return Result.ok(registerConfiguration.getEmailCheck());
    }

    @GetMapping("/captchaImage")
    public Result getCodeImg(){
        // 返回map为结果集
        Boolean isOpen = loginCodeConfiguration.getOpen();
        Map<String, Object> result = new HashMap<>();
        result.put("captchaEnabled", isOpen);
        if (!isOpen) return Result.ok(result);

        // 判断是数字图片还是字符图片
        String type = loginCodeConfiguration.getType();
        String capStr = null, code = null;
        BufferedImage image = null;
        if ("math".equals(type)){
            String capText = captchaProducerMath.createText();
            capStr = capText.substring(0, capText.lastIndexOf("@"));
            code = capText.substring(capText.lastIndexOf("@") + 1);
            image = captchaProducerMath.createImage(capStr);
        }else if ("char".equals(type)){
            capStr = code = captchaProducer.createText();
            image = captchaProducer.createImage(capStr);
        }

        // 存入redis
        String uuid = UUID.randomUUID().toString();
        String key = CommonConstant.LOGIN_CODE_KEY + uuid;
        redisTemplate.opsForValue().set(key, code, CommonConstant.LOGIN_CODE_KEY_TTL, TimeUnit.MINUTES);

        // 转换流信息写出
        FastByteArrayOutputStream os = new FastByteArrayOutputStream();
        try
        {
            ImageIO.write(image, "jpg", os);
        }
        catch (IOException e)
        {
            return Result.fail(e.getMessage());
        }

        // 封装返回数据(captchaEnabled、uuid、image)
        result.put("uuid", uuid);
        result.put("image", Base64.encode(os.toByteArray()));
        return Result.ok(result);
    }
}
