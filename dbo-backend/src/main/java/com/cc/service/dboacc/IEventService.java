package com.cc.service.dboacc;

import com.cc.entity.Event;
import com.cc.vo.Result;

import java.util.List;

public interface IEventService {
    List<Event> getEventList();

    Result adminEventSave(Event event);

    Result adminEventUpdate(Event event);

    Result adminEventDelete(Long id);
}
