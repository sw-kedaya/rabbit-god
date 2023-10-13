package com.cc;

import com.cc.entity.Mail;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

//@SpringBootTest
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
        System.out.println("当前的时间戳(秒)：" + current);
        System.out.println("十天后时间戳(秒)：" + ten);
        LocalDateTime currentDate = LocalDateTime.ofInstant(Instant.ofEpochSecond(current), ZoneId.systemDefault());
        LocalDateTime tenDate = LocalDateTime.ofInstant(Instant.ofEpochSecond(ten), ZoneId.systemDefault());
        System.out.println("当前的日期：" + currentDate);
        System.out.println("十天后日期：" + tenDate);
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

    @Test
    void testBinary() {
        LocalDateTime now = LocalDateTime.now();
        int day = now.getDayOfMonth() - 1;
        int result = 1;
        result <<= day - 1;
        System.out.println(result);
        int max = 2147483647;
        System.out.println(max);
        System.out.println(max + 1);
    }

    @Test
    void testSignedAnalysis() {
        long sign = 12388L;
        // 解析
        int[] result = new int[32];
        // 已签到日期
        List<Integer> signed = new ArrayList<>();
        // 未签到日期
        List<Integer> notSigned = new ArrayList<>();
        for (int i = 0; i < result.length; i++) {
            long isSigned = sign & 1;
            sign = sign >>> 1;
            result[i] = (int) isSigned;
            if (i > LocalDate.now().getDayOfMonth()) break;
            if (isSigned == 1) {
                signed.add(i);
            } else {
                notSigned.add(i);
            }
        }
        for (int i = 0; i < result.length; i++) {
            System.out.print(result[i]);
            if (i % 4 == 0) System.out.print(" ");
        }
        System.out.println();
        System.out.println(signed);
        System.out.println(notSigned);
    }
}
