package com.oldschool.ticketer.view.navigation;

import android.content.Context;
import com.oldschool.ticketer.models.datamodels.Ticket;

public interface Navigator {
    void showTicketsList(Context from);
    void showTicketPreview(Context from, Ticket ticket);
}
