package com.cc.mapper.dboacc;

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

    Integer checkUserCashById(@PathVariable("id") Long id,
                           @PathVariable("price") Long price);

    Account getLatestMallPoints(@PathVariable("id") Long id);

    Account getCardCount(@PathVariable("id") Long id);

    Integer addCardCountById(@PathVariable("id") Long id);

    Integer subCardCountById(@PathVariable("id") Long id);

    Integer addCardCountLimit(@PathVariable("id") Long id);

    void resetCardCount();

    Integer isBlock(@PathVariable("id") Long id);
}
