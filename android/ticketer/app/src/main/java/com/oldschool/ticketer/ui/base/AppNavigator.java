package com.oldschool.ticketer.ui.base;

import android.content.Context;
import android.content.Intent;
import com.oldschool.ticketer.core.datamodel.Ticket;
import com.oldschool.ticketer.ui.ticketlist.TicketsListActivity;
import com.oldschool.ticketer.ui.ticketpreview.TicketPreviewActivity;

public class AppNavigator {
    public void showTicketsList(Context from) {
        from.startActivity(new Intent(from, TicketsListActivity.class));
    }

    public void showTicketPreview(Context from, Ticket ticket) {
        from.startActivity(TicketPreviewActivity.getShowTicketIntent(from, ticket));
    }
}
