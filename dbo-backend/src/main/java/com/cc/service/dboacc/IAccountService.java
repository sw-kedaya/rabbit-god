package com.cc.service.dboacc;

import com.cc.dto.AccountDTO;
import com.cc.dto.PasswordDTO;
import com.cc.vo.Result;

import javax.servlet.http.HttpServletRequest;

public interface IAccountService {
    Result register(AccountDTO accountDTO, HttpServletRequest request);

    Result login(AccountDTO accountDTO);

    Result forgetPassword(String username);

    Result updatePwd(PasswordDTO passwordDTO);

    boolean isAdmin(Long id);
}
