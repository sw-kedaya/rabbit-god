package com.cc.mapper.dboacc;

import com.cc.entity.Event;

import java.util.List;

public interface EventMapper {
    List<Event> getEventList();

    Integer adminEventSave(Event event);

    Integer adminEventUpdate(Event event);

    Integer adminEventDelete(Long id);
}
