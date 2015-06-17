package com.oldschool.ticketer.view.ticketlist;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import com.oldschool.ticketer.R;
import com.oldschool.ticketer.models.datamodels.Ticket;
import com.oldschool.ticketer.view.navigation.DefaultNavigator;

import java.util.List;

public class TicketsListAdapter extends RecyclerView.Adapter<TicketsListAdapter.TicketViewHolder> {
    private List<Ticket> ticketsList;
    private Context context;
    private DefaultNavigator navigator;

    public TicketsListAdapter(Context context, List<Ticket> ticketsList) {
        this.context = context;
        this.ticketsList = ticketsList;
        navigator = new DefaultNavigator();
    }

    @Override
    public int getItemCount() {
        return ticketsList.size();
    }

    @Override
    public void onBindViewHolder(TicketViewHolder ticketViewHolder, final int i) {
        Ticket ticket = ticketsList.get(i);
        ticketViewHolder.trainName.setText(ticket.getTrainName());
        ticketViewHolder.name.setText(ticket.getName());
        ticketViewHolder.from.setText(ticket.getDepartureStation());
        ticketViewHolder.to.setText(ticket.getArrivalStation());
        ticketViewHolder.container.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                navigator.showTicketPreview(context, ticketsList.get(i));
            }
        });
    }

    @Override
    public TicketViewHolder onCreateViewHolder(ViewGroup viewGroup, int i) {
        View itemView = LayoutInflater.
                from(viewGroup.getContext()).
                inflate(R.layout.row_ticket, viewGroup, false);
        return new TicketViewHolder(itemView);
    }

    public static class TicketViewHolder extends RecyclerView.ViewHolder {
        protected View container;
        protected TextView trainName;
        protected TextView name;
        protected TextView from;
        protected TextView to;

        public TicketViewHolder(View v) {
            super(v);
            container = v.findViewById(R.id.card);
            trainName = (TextView) v.findViewById(R.id.train_name);
            name = (TextView) v.findViewById(R.id.name);
            from = (TextView) v.findViewById(R.id.from);
            to = (TextView) v.findViewById(R.id.to);
        }
    }
}