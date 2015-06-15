package com.oldschool.ticketer.core.stories.executor;

import rx.Scheduler;

public interface PostExecutionThread {
    Scheduler getScheduler();
}
