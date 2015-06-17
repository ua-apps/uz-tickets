package com.oldschool.ticketer.core.storage.base;

import com.oldschool.ticketer.models.datamodels.Ticket;

import java.util.List;

public interface TicketsStorage {
    void saveTicket(Ticket data);
    List<Ticket> getTickets();
}
