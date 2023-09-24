package com.cc.excepition;

import com.cc.vo.Result;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.sql.SQLIntegrityConstraintViolationException;

@RestControllerAdvice
public class MyExceptionHandler {
    @ExceptionHandler(SQLIntegrityConstraintViolationException.class)
    public Result userRepeat(){
        return Result.fail("用户名重复");
    }

    @ExceptionHandler(RuntimeException.class)
    public Result commonException(Exception e){
        e.printStackTrace();
        return Result.fail("未知错误，请联系管理员");
    }
}
