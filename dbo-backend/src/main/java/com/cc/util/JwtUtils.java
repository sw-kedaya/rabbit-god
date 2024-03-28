package com.cc.util;

import com.cc.entity.CommonConstant;
import io.jsonwebtoken.*;

import java.util.Date;
import java.util.UUID;

public class JwtUtils {
    public static String generatorToken(String username) {
        JwtBuilder builder = Jwts.builder();
        return builder
                .setHeaderParam("rabbit-god", "TuShenLingYu")
                .claim("username", username)
                .setSubject("token")
                .setExpiration(new Date(System.currentTimeMillis() + CommonConstant.TOKEN_TTL)) // 60分钟有效期
                .setId(UUID.randomUUID().toString())
                .signWith(SignatureAlgorithm.HS256, CommonConstant.SIGN)
                .compact();
    }

    public static boolean checkToken(String token){
        if (token == null) return false;
        try {
            Jwts.parser().setSigningKey(CommonConstant.SIGN).parseClaimsJws(token);
        }catch (Exception e){
            return false;
        }
        return true;
    }
}
