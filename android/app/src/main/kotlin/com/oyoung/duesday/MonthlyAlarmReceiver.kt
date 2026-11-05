package com.oyoung.duesday

import android.app.AlarmManager
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import org.json.JSONObject
import java.time.LocalTime
import java.time.ZoneId
import java.time.ZonedDateTime

// Schedule the next occurrence after each delivery, recalculating month length and DST.
class MonthlyAlarmReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val prefs = context.getSharedPreferences("monthly_alarms", Context.MODE_PRIVATE)
        val id = intent.getIntExtra("id", -1)
        if (!intent.hasExtra("id")) {
            prefs.all.values.filterIsInstance<String>().forEach {
                MonthlyAlarms.schedule(context, JSONObject(it))
            }
            return
        }
        val stored = prefs.getString(id.toString(), null) ?: return
        val alarm = JSONObject(stored)
        val manager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        if (Build.VERSION.SDK_INT >= 26) {
            manager.createNotificationChannel(NotificationChannel(
                "channel id", "channel name", NotificationManager.IMPORTANCE_HIGH))
        }
        val launch = context.packageManager.getLaunchIntentForPackage(context.packageName)!!
        val contentIntent = PendingIntent.getActivity(context, id, launch,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        val builder = if (Build.VERSION.SDK_INT >= 26) Notification.Builder(context, "channel id")
                      else Notification.Builder(context)
        val title = alarm.optString("title")
        val days = alarm.getInt("days")
        val notification = builder.setContentTitle("Duesday")
            .setContentText(if (days == 0) title else "D-$days $title")
            .setSmallIcon(context.applicationInfo.icon)
            .setContentIntent(contentIntent).setAutoCancel(true)
            .setDefaults(Notification.DEFAULT_ALL).build()
        try {
            manager.notify(id, notification)
        } catch (_: SecurityException) {
            // Permission denial must not crash a background receiver.
        } finally {
            MonthlyAlarms.schedule(context, alarm)
        }
    }
}

object MonthlyAlarms {
    private fun pending(context: Context, id: Int): PendingIntent = PendingIntent.getBroadcast(
        context, id, Intent(context, MonthlyAlarmReceiver::class.java).putExtra("id", id),
        PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)

    fun save(context: Context, arguments: Map<*, *>) {
        val alarm = JSONObject(arguments)
        val id = alarm.getInt("id")
        schedule(context, alarm)
        context.getSharedPreferences("monthly_alarms", Context.MODE_PRIVATE)
            .edit().putString(id.toString(), alarm.toString()).apply()
    }

    fun cancel(context: Context, id: Int) {
        context.getSharedPreferences("monthly_alarms", Context.MODE_PRIVATE)
            .edit().remove(id.toString()).apply()
        (context.getSystemService(Context.ALARM_SERVICE) as AlarmManager).cancel(pending(context, id))
        (context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager).cancel(id)
    }

    internal fun nextOccurrence(now: ZonedDateTime, requestedDay: Int,
                                hour: Int, minute: Int, days: Int): ZonedDateTime {
        var month = now.toLocalDate().withDayOfMonth(1)
        while (true) {
            val day = if (requestedDay == -1) month.lengthOfMonth()
                      else minOf(requestedDay, month.lengthOfMonth())
            val next = month.withDayOfMonth(day).minusDays(days.toLong())
                .atTime(LocalTime.of(hour, minute)).atZone(now.zone)
            if (next.isAfter(now)) return next
            month = month.plusMonths(1)
        }
    }

    fun schedule(context: Context, alarm: JSONObject) {
        val next = nextOccurrence(ZonedDateTime.now(ZoneId.systemDefault()),
            alarm.getInt("date"), alarm.getInt("hour"), alarm.getInt("minute"), alarm.getInt("days"))
        val manager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val operation = pending(context, alarm.getInt("id"))
        val trigger = next.toInstant().toEpochMilli()
        if (Build.VERSION.SDK_INT < 31 || manager.canScheduleExactAlarms()) {
            manager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, trigger, operation)
        } else {
            manager.setAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, trigger, operation)
        }
    }
}
