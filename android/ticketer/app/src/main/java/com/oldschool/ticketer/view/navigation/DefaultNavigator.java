package com.oldschool.ticketer.view.navigation;

import android.content.Context;
import android.content.Intent;
import com.oldschool.ticketer.models.datamodels.Ticket;
import com.oldschool.ticketer.view.ticketlist.TicketsListActivity;
import com.oldschool.ticketer.view.ticketpreview.TicketPreviewActivity;

import javax.inject.Inject;

public class DefaultNavigator implements Navigator {

    @Inject DefaultNavigator() {}

    @Override public void showTicketsList(Context from) {
        from.startActivity(new Intent(from, TicketsListActivity.class));
    }

    @Override public void showTicketPreview(Context from, Ticket ticket) {
        from.startActivity(TicketPreviewActivity.getShowTicketIntent(from, ticket));
    }
}
