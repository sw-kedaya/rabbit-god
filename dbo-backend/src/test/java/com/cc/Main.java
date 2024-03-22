package com.cc;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Main {
    public static void main(String[] args) {
        String dateStr = "20230925001526";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        LocalDateTime dateTime = LocalDateTime.parse(dateStr, formatter);
        
        System.out.println("转换后的LocalDateTime格式为：" + dateTime);

        int seconds = 10000000;
        int hours = seconds / 3600;
        System.out.println(seconds + "秒转换为小时为：" + hours);
    }
}