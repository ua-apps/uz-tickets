package com.oldschool.ticketer.core.qr.scanner;

import android.app.Activity;
import android.content.Intent;
import com.oldschool.ticketer.core.datamodel.Ticket;

public interface TicketScanner {
    void scanTicket(int responseCode, Activity onResultListener);
    Ticket parseData(Intent response);
}
