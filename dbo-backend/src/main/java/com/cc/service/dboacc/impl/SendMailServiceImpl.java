package com.cc.service.dboacc.impl;

import com.cc.service.dboacc.ISendMailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class SendMailServiceImpl implements ISendMailService {
    @Autowired
    private JavaMailSender javaMailSender;
    @Value("${spring.mail.username}")
    private String from;

    @Override
    public void sendMailForRegister(String email, String code) {
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setFrom(from);
        mailMessage.setTo(email);
        mailMessage.setSubject("七龙珠Online注册验证码");
        mailMessage.setText("您的注册验证码是：" + code + "，验证码5分钟有效，请勿将验证码告诉别人。");
        javaMailSender.send(mailMessage);
    }

    @Override
    public void sendMailForForget(String email, String password) {
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setFrom(from);
        mailMessage.setTo(email);
        mailMessage.setSubject("七龙珠Online找回密码");
        mailMessage.setText("密码已找回：" + password);
        javaMailSender.send(mailMessage);
    }
}
