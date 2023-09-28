package com.cc.mapper.dboacc;

import com.cc.dto.PasswordDTO;
import com.cc.entity.Account;
import org.springframework.web.bind.annotation.PathVariable;

public interface AccountMapper {
    void register(Account account);

    Account isUserRepeat(String username);

    Account checkUserPwd(Account account);

    Integer checkIpNum(String ip);

    Integer checkEmailNum(String email);

    Account getPassword(String username);

    Integer updatePwd(@PathVariable("newPassword") String newPassword,
                      @PathVariable("username") String username,
                      @PathVariable("md5") String md5);

    Integer addMallPoints(@PathVariable("accountID") Long accountID,
                          @PathVariable("cash") Long cash);

    Integer isAdmin(@PathVariable("id") Long id);
}
