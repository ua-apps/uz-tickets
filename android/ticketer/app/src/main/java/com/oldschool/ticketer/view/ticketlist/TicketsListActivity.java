package com.oldschool.ticketer.view.ticketlist;

import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import butterknife.InjectView;
import com.oldschool.ticketer.R;
import com.oldschool.ticketer.models.datamodels.Ticket;
import com.oldschool.ticketer.core.storage.TicketSharedPreferences;
import com.oldschool.ticketer.core.storage.base.TicketsStorage;
import com.oldschool.ticketer.view.navigation.DefaultNavigator;
import com.oldschool.ticketer.view.base.BaseActivity;

import java.util.ArrayList;
import java.util.List;

public class TicketsListActivity extends BaseActivity {
    private final int LAYOUT_ID = R.layout.activity_tickets_list;
    private DefaultNavigator navigator = new DefaultNavigator();
    private TicketsListAdapter adapter;
    private List<Ticket> tickets;
    private TicketsStorage ticketsStorage;

    @InjectView(R.id.ticket_list)
    RecyclerView ticketsList;

    @Override
    protected int getLayoutId() {
        return LAYOUT_ID;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        initTicketList();
    }

    @Override
    protected void onResume() {
        super.onResume();
        refreshTicketsList();
    }

    private void initTicketList() {
        ticketsStorage = new TicketSharedPreferences(this);
        ticketsList.setHasFixedSize(true);
        LinearLayoutManager llm = new LinearLayoutManager(this);
        llm.setOrientation(LinearLayoutManager.VERTICAL);
        ticketsList.setLayoutManager(llm);
        tickets = new ArrayList<Ticket>();
        adapter = new TicketsListAdapter(this, tickets);
        ticketsList.setAdapter(adapter);
    }

    private void refreshTicketsList() {
        tickets.clear();
        tickets.addAll(ticketsStorage.getTickets());
        adapter.notifyDataSetChanged();
    }
}