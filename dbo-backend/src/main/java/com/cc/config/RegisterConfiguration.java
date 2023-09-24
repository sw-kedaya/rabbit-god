package com.cc.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "register")
@Data
public class RegisterConfiguration {
    private Boolean open;
    private Boolean emailCheck;
    private Integer IpMaxNum;
    private Integer EmailMaxNum;
}
