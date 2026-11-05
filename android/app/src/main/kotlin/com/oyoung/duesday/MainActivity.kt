package com.oyoung.duesday

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.oyoung.duesday/alarms")
            .setMethodCallHandler { call, result ->
                if (call.method == "scheduleMonthly") {
                    try {
                        MonthlyAlarms.save(this, call.arguments as Map<*, *>)
                        result.success(null)
                    } catch (error: Exception) {
                        result.error("schedule_failed", error.message, null)
                    }
                } else if (call.method == "cancelMonthly") {
                    MonthlyAlarms.cancel(this, (call.arguments as Number).toInt())
                    result.success(null)
                } else {
                    result.notImplemented()
                }
            }
    }
}
