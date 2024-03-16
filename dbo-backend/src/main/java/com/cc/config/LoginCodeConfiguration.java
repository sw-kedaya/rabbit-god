package com.cc.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "login-code")
@Data
public class LoginCodeConfiguration {
    private Boolean open;
    private String type;
}
