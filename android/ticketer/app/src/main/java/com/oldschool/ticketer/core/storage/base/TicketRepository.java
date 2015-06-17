package com.oldschool.ticketer.core.storage.base;

import com.oldschool.ticketer.models.datamodels.Ticket;
import rx.Observable;
import java.util.List;

public interface TicketRepository {
    Observable<List<Ticket>> getTickets();
    void saveTicket(Ticket ticket);
}
