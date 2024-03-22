package com.cc.util;

public class ThreadLocalUtils {
    private static final ThreadLocal<Long> threadLocal = new ThreadLocal<>();

    public static void setUserId(Long id){
        threadLocal.set(id);
    }

    public static Long getUserId(){
        return threadLocal.get();
    }

    public static void removeUserId(){
        threadLocal.remove();
    }
}
