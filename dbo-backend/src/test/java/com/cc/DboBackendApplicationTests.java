package com.cc;

import cn.hutool.log.Log;
import com.cc.entity.Mail;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.*;
import java.util.Date;
import java.util.UUID;

@SpringBootTest
class DboBackendApplicationTests {

    @Test
    void testCdKey() {
        String uuid = UUID.randomUUID().toString().replace("-", "").toUpperCase();
        System.out.println("卡密：" + uuid);
        System.out.println("位数：" + uuid.length());
    }

    @Test
    void testCdKey10() {
        for (int i = 0; i < 10; i++) {
            String uuid = UUID.randomUUID().toString().replace("-", "").toUpperCase();
            System.out.println("卡密：" + uuid);
        }
    }

    @Test
    void testLocalDateTime() {
        long current = LocalDateTime.now().toEpochSecond(ZoneOffset.UTC);
        long ten = LocalDateTime.now().plusDays(10).toEpochSecond(ZoneOffset.UTC);
        System.out.println("当前的时间戳(秒)："+current);
        System.out.println("十天后时间戳(秒)："+ten);
        LocalDateTime currentDate = LocalDateTime.ofInstant(Instant.ofEpochSecond(current), ZoneId.systemDefault());
        LocalDateTime tenDate = LocalDateTime.ofInstant(Instant.ofEpochSecond(ten), ZoneId.systemDefault());
        System.out.println("当前的日期："+currentDate);
        System.out.println("十天后日期："+tenDate);
        System.out.println("-------------------------------------");
        int year = LocalDateTime.now().getYear();
        int month = LocalDateTime.now().getMonthValue();
        int day = LocalDateTime.now().getDayOfMonth();
        int hour = LocalDateTime.now().getHour();
        int minute = LocalDateTime.now().getMinute();
        int second = LocalDateTime.now().getSecond();
        System.out.println(year);
        System.out.println(month);
        System.out.println(day);
        System.out.println(hour);
        System.out.println(minute);
        System.out.println(second);
    }

    @Test
    void testMail() {
        Mail mail = new Mail();
        System.out.println(mail);
    }
}
