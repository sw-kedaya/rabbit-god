package com.cc.util;

public class DBOCharParseFiledUtils {

    public static String parseDboClass(int dboClass){
        switch (dboClass){
            case 0:
                return "武道家";
            case 1:
                return "气功师";
            case 2:
                return "工程师";
            case 3:
                return "那美克战士";
            case 4:
                return "那美克龙族";
            case 5:
                return "大魔人";
            case 6:
                return "意魔人";
            case 7:
                return "格斗家";
            case 8:
                return "剑术家";
            case 9:
                return "鹤仙流";
            case 10:
                return "龟仙流";
            case 13:
                return "魔界战士";
            case 14:
                return "魔道战士";
            case 15:
                return "天天导师";
            case 16:
                return "波可导师";
            case 17:
                return "奥迪魔";
            case 18:
                return "葛兰魔";
            case 19:
                return "普利兹魔";
            case 20:
                return "卡尔魔";
        }
        return "未知";
    }
}
