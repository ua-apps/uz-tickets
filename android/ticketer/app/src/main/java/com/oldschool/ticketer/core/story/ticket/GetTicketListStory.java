package com.oldschool.ticketer.core.story.ticket;

import com.oldschool.ticketer.core.storage.base.TicketRepository;
import com.oldschool.ticketer.core.story.base.Story;
import com.oldschool.ticketer.core.story.executor.PostExecutionThread;
import com.oldschool.ticketer.core.story.executor.ThreadExecutor;
import rx.Observable;
import javax.inject.Inject;

public class GetTicketListStory extends Story {

    private final TicketRepository ticketRepository;

    @Inject
    public GetTicketListStory(TicketRepository ticketRepository, ThreadExecutor threadExecutor, PostExecutionThread postExecutionThread) {
        super(threadExecutor, postExecutionThread);
        this.ticketRepository = ticketRepository;
    }

    @Override public Observable buildStoryObservable() {
        return this.ticketRepository.getTickets();
    }
}
