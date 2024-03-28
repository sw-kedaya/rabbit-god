package com.cc.service.dbochar.impl;

import com.cc.dto.MallOrderDTO;
import com.cc.entity.DBOChar;
import com.cc.entity.Mail;
import com.cc.mapper.dbochar.DBOCharMapper;
import com.cc.mapper.dbochar.MailMapper;
import com.cc.service.dbochar.IMailService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class MailServiceImpl implements IMailService {
    @Resource
    private MailMapper mailMapper;
    @Resource
    private DBOCharMapper dboCharMapper;

    @Override
    public MallOrderDTO generateMail(String roleName, Long itemId, Long count) {
        DBOChar dboChar = dboCharMapper.getCharIDByCharName(roleName);
        if (dboChar == null || dboChar.getCharID() == null) return null;
        Mail mail = new Mail();
        mail.setCharID(dboChar.getCharID());
        mail.setTargetName(roleName);
        mail.setItemId(itemId);
        mail.setCount(count);
        Integer integer = mailMapper.generateMail(mail);
        if (integer <= 0) return null;
        MallOrderDTO mallOrderDTO = new MallOrderDTO();
        mallOrderDTO.setCharId(dboChar.getCharID());
        mallOrderDTO.setBuyTime(mail.getCurrentTime());
        return mallOrderDTO;
    }

    @Override
    public void generateSignMail(String roleName, Long itemId, Long count) {
        DBOChar dboChar = dboCharMapper.getCharIDByCharName(roleName);
        if (dboChar == null || dboChar.getCharID() == null) return;
        Mail mail = new Mail();
        mail.setFromName("签到奖励");
        mail.setText("感谢使用Web在线签到功能，祝您游戏愉快！");
        mail.setCharID(dboChar.getCharID());
        mail.setTargetName(roleName);
        mail.setItemId(itemId);
        mail.setCount(count);
        mailMapper.generateMail(mail);
    }

    @Override
    public void generateReplacementSignMail(String roleName, Long itemId, Long count) {
        DBOChar dboChar = dboCharMapper.getCharIDByCharName(roleName);
        if (dboChar == null || dboChar.getCharID() == null) return;
        Mail mail = new Mail();
        mail.setFromName("补签奖励");
        mail.setText("感谢使用Web在线补签功能，祝您游戏愉快！");
        mail.setCharID(dboChar.getCharID());
        mail.setTargetName(roleName);
        mail.setItemId(itemId);
        mail.setCount(count);
        mailMapper.generateMail(mail);
    }

    @Override
    public void generateAuctionMail(String roleName, Long itemId, Long count) {
        DBOChar dboChar = dboCharMapper.getCharIDByCharName(roleName);
        if (dboChar == null || dboChar.getCharID() == null) return;
        Mail mail = new Mail();
        mail.setFromName("拍卖成功");
        mail.setText("感谢使用Web在线拍卖功能，祝您游戏愉快！");
        mail.setCharID(dboChar.getCharID());
        mail.setTargetName(roleName);
        mail.setItemId(itemId);
        mail.setCount(count);
        mailMapper.generateMail(mail);
    }
}
