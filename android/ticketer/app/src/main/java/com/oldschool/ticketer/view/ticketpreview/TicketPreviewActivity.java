package com.oldschool.ticketer.view.ticketpreview;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.widget.ImageView;
import butterknife.InjectView;
import butterknife.OnClick;
import com.oldschool.ticketer.R;
import com.oldschool.ticketer.models.datamodels.Ticket;
import com.oldschool.ticketer.core.qr.creator.QRCreator;
import com.oldschool.ticketer.core.qr.creator.QRProvider;
import com.oldschool.ticketer.core.storage.TicketSharedPreferences;
import com.oldschool.ticketer.core.storage.base.TicketsStorage;
import com.oldschool.ticketer.view.base.BaseActivity;

public class TicketPreviewActivity extends BaseActivity {
    private final int LAYOUT_ID = R.layout.activity_ticket_preview;
    private Ticket ticket;
    private QRProvider qrProvider = new QRCreator();

    @InjectView(R.id.qr_code)
    ImageView qrCode;

    @OnClick(R.id.save_ticket)
    void saveTicket() {
        TicketsStorage storage = new TicketSharedPreferences(this);
        storage.saveTicket(ticket);
        finish();
    }

    @Override
    protected int getLayoutId() {
        return LAYOUT_ID;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getTicket();
        showQRCode();
    }

    private void getTicket() {
        ticket = (Ticket) getIntent().getExtras().getSerializable(KEY_TICKET);
        if (ticket == null) {
            finish();
        }
    }

    private void showQRCode() {
        Bitmap ticketQR = qrProvider.getQR(ticket.getAllData(), 400, 400);
        qrCode.setImageBitmap(ticketQR);
    }

    private static final String KEY_TICKET = "KEY_TICKET";
    public static Intent getShowTicketIntent(Context from, Ticket ticket) {
        Intent ticketToShow = new Intent(from, TicketPreviewActivity.class);
        ticketToShow.putExtra(KEY_TICKET, ticket);
        return ticketToShow;
    }
}