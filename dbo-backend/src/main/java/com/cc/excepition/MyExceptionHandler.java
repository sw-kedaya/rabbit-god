package com.cc.excepition;

import com.cc.vo.Result;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.sql.SQLIntegrityConstraintViolationException;

@RestControllerAdvice
public class MyExceptionHandler {
    @ExceptionHandler(SQLIntegrityConstraintViolationException.class)
    public Result userRepeat(Exception e){
        e.printStackTrace();
        return Result.fail("用户名重复");
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public Result dataError(Exception e){
        e.printStackTrace();
        return Result.fail("存在非法数据，请检查数据！");
    }

    @ExceptionHandler(RuntimeException.class)
    public Result commonException(Exception e){
        e.printStackTrace();
        return Result.fail("未知错误，请联系管理员");
    }
}
