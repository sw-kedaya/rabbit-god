package com.cc.service.dbochar;

import com.cc.dto.MallOrderDTO;
import com.cc.entity.Mail;

public interface IMailService {
    MallOrderDTO generateMail(String roleName, Long itemId, Long count);

    void generateSignMail(String roleName, Long itemId, Long count);

    void generateReplacementSignMail(String roleName, Long itemId, Long count);
}
