package com.oldschool.ticketer.models.mappers;


import com.oldschool.ticketer.models.datamodels.Ticket;
import com.oldschool.ticketer.models.datamodels.TicketUIModel;

import javax.inject.Inject;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;

public class TicketUIModelMapper {

    @Inject
    public TicketUIModelMapper() {
        /*added for Inject resolving*/
    }

    public TicketUIModel transform(Ticket ticket) {
        if (ticket == null) {
            throw new IllegalArgumentException("Cannot transform a null value");
        }
        TicketUIModel ticketUIModel = new TicketUIModel();
        //TODO: should add the mapping
        return ticketUIModel;
    }

    public Collection<TicketUIModel> transform(Collection<Ticket> ticketsCollection) {
        Collection<TicketUIModel> ticketUIModelsCollection;

        if (ticketsCollection != null && !ticketsCollection.isEmpty()) {
            ticketUIModelsCollection = new ArrayList<TicketUIModel>();
            for (Ticket ticket : ticketsCollection) {
                ticketUIModelsCollection.add(transform(ticket));
            }
        } else {
            ticketUIModelsCollection = Collections.emptyList();
        }

        return ticketUIModelsCollection;
    }
}
