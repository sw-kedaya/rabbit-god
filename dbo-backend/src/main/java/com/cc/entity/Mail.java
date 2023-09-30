package com.cc.entity;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneOffset;

@Data
public class Mail {
    private Long id;
    private Long charID;
    private Integer senderType = 3;
    private Integer mailType = 2;
    private Integer textSize = 50;
    private String text = "感谢使用Web在线商城购买道具，祝您游戏愉快！";
    private Long zenny = 0L;
    /** 对应mall表的：tblidx */
    private Long itemId;
    private String targetName;
    private String fromName = "在线胶囊商城";
    private Integer isAccept = 0;
    private Integer isLock = 0;
    private Integer isRead = 0;
    /** 这个属性不属于数据库，只是辅助算出时间。*/
    private LocalDateTime currentTime = LocalDateTime.now();
    /** 开始结束时间都用时间戳(秒为单位)，保留时间要放前面，不然endTime调用会空指针。*/
    private Integer remainDay = 10;
    private Long createTime = currentTime.toEpochSecond(ZoneOffset.UTC);
    private Long endTime = currentTime.plusDays(this.remainDay).toEpochSecond(ZoneOffset.UTC);
    private Integer year = currentTime.getYear();
    private Integer month = currentTime.getMonthValue();
    private Integer day = currentTime.getDayOfMonth();
    private Integer hour = currentTime.getHour();
    private Integer minute = currentTime.getMinute();
    private Integer second = currentTime.getSecond();
    /** 网站发送用1，系统才是0 */
    private Integer system = 1;
    /** 物品数量 */
    private Long count;
}
