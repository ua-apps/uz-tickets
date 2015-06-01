package com.oldschool.ticketer.core.qr.creator;

import android.graphics.Bitmap;

public interface QRProvider {
    Bitmap getQR(String data, int width, int height);
}
