package com.oldschool.ticketer.di;

import com.oldschool.ticketer.core.story.base.Story;
import com.oldschool.ticketer.core.story.ticket.GetTicketListStory;
import com.oldschool.ticketer.view.navigation.DefaultNavigator;
import com.oldschool.ticketer.view.navigation.Navigator;
import dagger.Module;
import dagger.Provides;

import javax.inject.Named;

@Module
public class NavigatorModule {

    public NavigatorModule() {}

    @Provides
    Navigator provideNavigator(DefaultNavigator defaultNavigator) {
        return defaultNavigator;
    }
}
