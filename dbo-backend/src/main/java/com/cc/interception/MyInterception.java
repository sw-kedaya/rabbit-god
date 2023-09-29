package com.cc.interception;

import cn.hutool.json.JSONUtil;
import com.cc.entity.User;
import com.cc.util.JwtUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class MyInterception implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String header = request.getHeader("Rg-Msg");
        String json = request.getHeader("authorization");
        if (json == null || json.isEmpty()){
            // 设置响应状态码为 401（未授权）
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            // 设置响应内容为错误信息
            response.getWriter().write("Unauthorized");
            return false;
        }
        User user = JSONUtil.toBean(json, User.class);
        boolean isSuccess = JwtUtils.checkToken(user.getToken());
        if (!"Online".equals(header) || !isSuccess) {
            // 设置响应状态码为 401（未授权）
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            // 设置响应内容为错误信息
            response.getWriter().write("Unauthorized");
            return false;
        }
        return true;
    }
}
