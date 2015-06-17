package com.oldschool.ticketer.presenters;

import com.oldschool.ticketer.core.story.base.DefaultSubscriber;
import com.oldschool.ticketer.core.story.base.Story;
import com.oldschool.ticketer.di.StoryModule;
import com.oldschool.ticketer.models.datamodels.TicketUIModel;
import com.oldschool.ticketer.models.mappers.TicketUIModelMapper;
import com.oldschool.ticketer.models.datamodels.Ticket;
import com.oldschool.ticketer.presenters.base.Presenter;
import com.oldschool.ticketer.view.ticketlist.TicketListView;
import java.util.Collection;
import java.util.List;
import javax.inject.Inject;
import javax.inject.Named;
import android.support.annotation.NonNull;

public class TicketListPresenter extends DefaultSubscriber<List<Ticket>> implements Presenter {

    private TicketListView ticketListView;

    private final Story getTicketListStory;
    private final TicketUIModelMapper ticketUIModelMapper;

    @Inject
    public TicketListPresenter(@Named(StoryModule.TICKET_LIST) Story getTicketListStory, TicketUIModelMapper ticketUIModelMapper) {
        this.getTicketListStory = getTicketListStory;
        this.ticketUIModelMapper = ticketUIModelMapper;
    }

    public void setView(@NonNull TicketListView view) {
        this.ticketListView = view;
    }

    @Override public void resume() {}

    @Override public void pause() {}

    @Override public void destroy() {
        this.getTicketListStory.unsubscribe();
    }

    public void initialize() {
        this.loadTicketList();
    }

    private void loadTicketList() {
        this.showViewLoading();
        this.getTicketList();
    }

    public void onAddTicketClicked() {
        this.ticketListView.addTicket();
    }

    public void onTicketClicked(TicketUIModel ticketUIModel) {
        this.ticketListView.viewTicket(ticketUIModel);
    }

    private void showViewLoading() {
        this.ticketListView.showLoading();
    }

    private void hideViewLoading() {
        this.ticketListView.hideLoading();
    }

    private void showErrorMessage(String errorMessage) {
        this.ticketListView.showError(errorMessage);
    }

    private void showTicketsCollectionInView(Collection<Ticket> tickets) {
        final Collection<TicketUIModel> ticketUIModels = this.ticketUIModelMapper.transform(tickets);
        this.ticketListView.showTickets(ticketUIModels);
    }

    private void getTicketList() {
        this.getTicketListStory.execute(this);
    }

    @Override public void onCompleted() {
        this.hideViewLoading();
    }

    @Override public void onError(Throwable e) {
        this.hideViewLoading();
        this.showErrorMessage(e.getMessage());
    }

    @Override public void onNext(List<Ticket> tickets) {
        this.showTicketsCollectionInView(tickets);
    }
}