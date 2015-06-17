package com.oldschool.ticketer.view.dashboard;

import android.content.Intent;
import butterknife.OnClick;
import com.oldschool.ticketer.R;
import com.oldschool.ticketer.models.datamodels.Ticket;
import com.oldschool.ticketer.core.qr.scanner.ExternalScanner;
import com.oldschool.ticketer.core.qr.scanner.TicketScanner;
import com.oldschool.ticketer.view.navigation.DefaultNavigator;
import com.oldschool.ticketer.view.base.BaseActivity;

public class DashboardActivity extends BaseActivity {
    private final int LAYOUT_ID = R.layout.activity_dashboard;
    private DefaultNavigator navigator = new DefaultNavigator();
    private TicketScanner scanner = new ExternalScanner();
    private final int CODE_DO_SCAN = 0;

    @Override
    protected int getLayoutId() {
        return LAYOUT_ID;
    }

    @OnClick(R.id.go_to_tickets_list)
    void goToTicketList() {
        navigator.showTicketsList(this);
    }

    @OnClick(R.id.scan_ticket)
    void scanTicket() {
        scanner.scanTicket(CODE_DO_SCAN, this);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == CODE_DO_SCAN) {
            if (resultCode == RESULT_OK) {
                Ticket ticket = scanner.parseData(data);
                navigator.showTicketPreview(this, ticket);
            }
        }
    }
}