package com.cc.service.dboacc;

public interface ISendMailService {
    void sendMailForRegister(String email, String code);

    void sendMailForForget(String email, String password);
}
