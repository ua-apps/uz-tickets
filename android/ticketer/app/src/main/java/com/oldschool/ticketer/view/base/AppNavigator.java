package com.oldschool.ticketer.view.base;

import android.content.Context;
import android.content.Intent;
import com.oldschool.ticketer.models.datamodels.Ticket;
import com.oldschool.ticketer.view.ticketlist.TicketsListActivity;
import com.oldschool.ticketer.view.ticketpreview.TicketPreviewActivity;

public class AppNavigator {
    public void showTicketsList(Context from) {
        from.startActivity(new Intent(from, TicketsListActivity.class));
    }

    public void showTicketPreview(Context from, Ticket ticket) {
        from.startActivity(TicketPreviewActivity.getShowTicketIntent(from, ticket));
    }
}
