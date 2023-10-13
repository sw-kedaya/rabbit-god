package com.cc.vo;

import lombok.Data;

import java.util.List;

@Data
public class SignMessage {
    private List<Integer> signed;
    private List<Integer> notSigned;
    private List<MallVO> mallList;
}
