package com.cc.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class MallOrderDTO {
    private Long charId;
    private LocalDateTime buyTime;
}
