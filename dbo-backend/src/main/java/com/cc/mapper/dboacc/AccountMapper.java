package com.cc.mapper.dboacc;

import com.cc.dto.AccountManagementDTO;
import com.cc.entity.Account;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AccountMapper {
    void register(Account account);

    Account isUserRepeat(String username);

    Account checkUserPwd(Account account);

    Integer checkIpNum(String ip);

    Integer checkEmailNum(String email);

    Account getPassword(String username);

    Integer updatePwd(@Param("newPassword") String newPassword,
                      @Param("username") String username,
                      @Param("md5") String md5);

    Integer addMallPoints(@Param("accountID") Long accountID,
                          @Param("cash") Long cash);

    Integer isAdmin(@Param("id") Long id);

    Integer checkUserCashById(@Param("id") Long id,
                           @Param("price") Long price);

    Account getLatestMallPoints(@Param("id") Long id);

    Account getCardCount(@Param("id") Long id);

    Integer addCardCountById(@Param("id") Long id);

    Integer subCardCountById(@Param("id") Long id);

    Integer addCardCountLimit(@Param("id") Long id);

    void resetCardCount();

    Integer isBlock(@Param("id") Long id);

    List<AccountManagementDTO> adminGetList();

    Integer adminUpdateBalance(AccountManagementDTO accountManagementDTO);

    Integer blockedAccount(@Param("id") Long id);

    Integer unblockedAccount(@Param("id") Long id);

    Integer isAuctionPointEnoughById(@Param("id") Long userId,
                                     @Param("price") Long price);

    Integer returnAuctionPrice(@Param("id") Long accountID,
                               @Param("currentPrice") Long currentPrice);
}
