package com.oldschool.ticketer.core.storage;

import android.content.Context;
import android.content.SharedPreferences;
import com.oldschool.ticketer.models.datamodels.Ticket;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class TicketSharedPreferences implements TicketsStorage {
    private final String KEY_TICKETS = "KEY_TICKETS";

    private SharedPreferences prefs;
    public TicketSharedPreferences(Context context) {
        prefs = context.getSharedPreferences(context.getPackageName(), Context.MODE_PRIVATE);
    }

    @Override
    public void saveTicket(Ticket data) {
        Set<String> tickets = prefs.getStringSet(KEY_TICKETS, new HashSet<String>());
        tickets.add(data.getAllData());
        prefs.edit().putStringSet(KEY_TICKETS, tickets).apply();
    }

    @Override
    public List<Ticket> getTickets() {
        List<String> data = new ArrayList<String>(prefs.getStringSet(KEY_TICKETS, new HashSet<String>()));
        List<Ticket> tickets = new ArrayList<Ticket>();
        for(String temp : data) {
            Ticket ticket = new Ticket();
            ticket.parseString(temp);
            tickets.add(ticket);
        }
        return tickets;
    }
}
