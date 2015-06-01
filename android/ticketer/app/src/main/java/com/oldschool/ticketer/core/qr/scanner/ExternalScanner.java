package com.oldschool.ticketer.core.qr.scanner;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import com.oldschool.ticketer.core.datamodel.Ticket;

public class ExternalScanner implements TicketScanner {
    @Override
    public void scanTicket(int responseCode, Activity resultActivity) {
        try {
            Intent intent = new Intent("com.google.zxing.client.android.SCAN");
            intent.putExtra("SCAN_MODE", "QR_CODE_MODE"); // "PRODUCT_MODE for bar codes
            resultActivity.startActivityForResult(intent, responseCode);
        } catch (Exception e) {
            Uri marketUri = Uri.parse("market://details?id=com.google.zxing.client.android");
            Intent marketIntent = new Intent(Intent.ACTION_VIEW, marketUri);
            resultActivity.startActivity(marketIntent);
        }
    }

    @Override
    public Ticket parseData(Intent response) {
        String qrData = response.getStringExtra("SCAN_RESULT");


        String format = response.getStringExtra("SCAN_RESULT_FORMAT");


        Ticket ticket = new Ticket();


        ticket.parseString(qrData);





        return ticket;
    }
}
