package ru.notifications.javalib;

// Qt
import org.qtproject.qt5.android.QtNative;

import android.app.PendingIntent;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.NotificationChannel;
import android.content.Intent;
import android.content.Context;
import android.graphics.Color;
import android.graphics.BitmapFactory;
import android.os.Build;

import java.lang.String;

import org.qtproject.example.R;

class QtAndroidNotifications {

    public static void show(String title, String messageBody, int id) {
        Context context = QtNative.activity();
        NotificationManager notificationManager = getManager();
        Notification.Builder builder =
                new Notification.Builder(context)
                //.setColor(0x008000)
                .setSmallIcon(R.drawable.icon)
                .setContentTitle(title)
                .setContentText(messageBody)
                .setAutoCancel(true);

        String packageName = context.getApplicationContext().getPackageName();
        Intent resultIntent = context.getPackageManager().getLaunchIntentForPackage(packageName);
        resultIntent.setFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);

        PendingIntent resultPendingIntent = PendingIntent.getActivity(context, 0,
            resultIntent, PendingIntent.FLAG_UPDATE_CURRENT);

        builder.setContentIntent(resultPendingIntent);
        notificationManager.notify(id, builder.build());
    }

    private static NotificationManager getManager() {
        Context context = QtNative.activity();
        return (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
    }
}
