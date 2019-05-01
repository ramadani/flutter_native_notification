package com.example.flutter_native_notification

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import android.os.Bundle
import android.support.v4.app.NotificationManagerCompat
import android.util.Log
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    private val CHANNEL = "fnn.ramadani.id/test_drive"
    private lateinit var methodChannel: MethodChannel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        methodChannel = MethodChannel(flutterView, CHANNEL)
        methodChannel.setMethodCallHandler { call, result ->
            if (call.method == "getTestDrive") {
                result.success("Ready to Test Drive")
            } else if (call.method == "notification") {
                showNotification()
            } else {
                result.notImplemented()
            }
        }
    }

    private fun showNotification() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Log.d("MainActivity", "showNotification")

            val channelId = "MY_NOTIFICATION_CHANNEL"
            val channelName = "my_notification_channel"
            val channelImportance = NotificationManager.IMPORTANCE_HIGH
            val channel = NotificationChannel(channelId, channelName, channelImportance)
            channel.description = "this is my notification channel"

            val notificationBuilder =  Notification.Builder(this, "great")
                    .setSmallIcon(R.mipmap.ic_launcher)
                    .setContentTitle("My Notification")
                    .setContentText("Hello World!")
                    .setChannelId(channelId)

            val notificationManager = (getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager)
            notificationManager.createNotificationChannel(channel)
            notificationManager.notify(5, notificationBuilder.build())

            methodChannel.invokeMethod("setTestDrive", "Hello From Notification!")
        } else {
            Log.d("MainActivity", "not yet implement")
        }
    }
}
