package com.cc.service.dboacc;

import com.cc.dto.AccountDTO;
import com.cc.dto.AccountManagementDTO;
import com.cc.dto.PasswordDTO;
import com.cc.vo.Result;

import javax.servlet.http.HttpServletRequest;

public interface IAccountService {
    Result register(AccountDTO accountDTO, HttpServletRequest request);

    Result login(AccountDTO accountDTO);

    Result forgetPassword(String username);

    Result updatePwd(PasswordDTO passwordDTO);

    boolean isAdmin(Long id);

    boolean checkUserCashById(Long id, Long price);

    Result getLatestMallPoints(Long id);

    Result getCardCount(Long accountID);

    Result subCardCountById(Long accountID);

    Result checkCardCountLimit(Long accountID);

    boolean isBlock(Long accountID);

    Result adminGetList();

    Result adminUpdateBalance(AccountManagementDTO accountManagementDTO);

    Result blockedAccount(Long id);

    Result unblockedAccount(Long id);

    boolean isAuctionPointEnoughById(Long userId, Long price);

    Integer returnAuctionPrice(Long accountID, Long currentPrice);
}
