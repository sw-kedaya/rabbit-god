package com.cc.util;

import java.util.UUID;

public class CashKeyUtils {
    /**
     * 生成卡密
     * @return 卡密
     */
    public static String generateKey(){
        return UUID.randomUUID().toString().replace("-", "").toUpperCase();
    }
}
