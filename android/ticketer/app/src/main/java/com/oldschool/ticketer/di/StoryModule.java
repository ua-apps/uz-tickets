package com.oldschool.ticketer.di;

import com.oldschool.ticketer.core.story.base.Story;
import com.oldschool.ticketer.core.story.ticket.GetTicketListStory;
import dagger.Module;
import dagger.Provides;

import javax.inject.Named;

@Module
public class StoryModule {

    public static final String TICKET_LIST = "TICKET_LIST";


    public StoryModule() {}

    @Provides @Named(TICKET_LIST)
    Story provideGetTicketListStory(GetTicketListStory getTicketListStory) {
        return getTicketListStory;
    }
}
