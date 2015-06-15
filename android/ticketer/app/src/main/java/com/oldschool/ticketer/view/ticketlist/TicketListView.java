package com.oldschool.ticketer.view.ticketlist;

import com.oldschool.ticketer.models.datamodels.TicketUIModel;
import java.util.Collection;

public interface TicketListView {
    void showLoading();
    void hideLoading();
    void showError(String message);
    void showTickets(Collection<TicketUIModel> tickets);
    void viewTicket(TicketUIModel ticket);
    void addTicket();
}
