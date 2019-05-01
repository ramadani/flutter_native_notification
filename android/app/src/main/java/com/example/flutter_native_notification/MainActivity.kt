package com.example.flutter_native_notification

import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    private val CHANNEL = "fnn.ramadani.id/test_drive"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getTestDrive") {
                result.success("Ready to Test Drive")
            } else {
                result.notImplemented()
            }
        }
    }
}
