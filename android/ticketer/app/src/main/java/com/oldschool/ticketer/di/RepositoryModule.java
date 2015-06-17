package com.oldschool.ticketer.di;

import com.oldschool.ticketer.core.storage.base.TicketRepository;
import com.oldschool.ticketer.core.story.base.Story;
import com.oldschool.ticketer.core.story.ticket.GetTicketListStory;
import com.oldschool.ticketer.models.datamodels.Ticket;
import dagger.Module;
import dagger.Provides;

import javax.inject.Named;

@Module
public class RepositoryModule {

    public RepositoryModule() {}

    @Provides TicketRepository provideGetTicketListStory(TicketDataRepository ticketDataRepository) {
        return ticketDataRepository;
    }
}
