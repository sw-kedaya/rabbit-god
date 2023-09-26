package com.cc;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.UUID;

@SpringBootTest
class DboBackendApplicationTests {

    @Test
    void testCdKey() {
        String uuid = UUID.randomUUID().toString().replace("-", "").toUpperCase();
        System.out.println("卡密："+uuid);
        System.out.println("位数："+uuid.length());
    }

    @Test
    void testCdKey10() {
        for (int i = 0; i < 10; i++) {
            String uuid = UUID.randomUUID().toString().replace("-", "").toUpperCase();
            System.out.println("卡密："+uuid);
        }
    }
}
