package com.oldschool.ticketer.core.story.executor;

import rx.Scheduler;

public interface PostExecutionThread {
    Scheduler getScheduler();
}
