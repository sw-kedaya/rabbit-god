package com.cc.entity;

import lombok.Data;

@Data
public class Event {
    private Long id;
    private String event_name;
    private String monday;
    private String tuesday;
    private String wednesday;
    private String thursday;
    private String friday;
    private String saturday;
    private String sunday;
}
