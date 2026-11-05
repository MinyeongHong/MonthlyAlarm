package com.oyoung.duesday

import org.junit.Assert.assertEquals
import org.junit.Test
import java.time.ZonedDateTime

class MonthlyAlarmsTest {
    @Test fun recalculatesLastDayAcrossShortAndLongMonths() {
        var now = ZonedDateTime.parse("2028-01-31T10:00:00+01:00[Europe/Rome]")
        for (expected in listOf("2028-02-29", "2028-03-31", "2028-04-30")) {
            now = MonthlyAlarms.nextOccurrence(now, -1, 9, 0, 0)
            assertEquals(expected, now.toLocalDate().toString())
        }
    }
    @Test fun clampsDay31AndRestoresItTheFollowingMonth() {
        val february = MonthlyAlarms.nextOccurrence(
            ZonedDateTime.parse("2026-01-31T10:00:00Z"), 31, 9, 0, 0)
        assertEquals("2026-02-28", february.toLocalDate().toString())
        assertEquals("2026-03-31", MonthlyAlarms.nextOccurrence(february, 31, 9, 0, 0)
            .toLocalDate().toString())
    }
    @Test fun reminderTracksTheTargetMonthAcrossYearBoundary() {
        val next = MonthlyAlarms.nextOccurrence(
            ZonedDateTime.parse("2026-12-25T10:00:00Z"), 1, 9, 0, 7)
        assertEquals("2027-01-25", next.toLocalDate().toString())
    }
    @Test fun keepsLocalTimeAcrossDaylightSavingChange() {
        val next = MonthlyAlarms.nextOccurrence(
            ZonedDateTime.parse("2026-03-01T10:00:00+01:00[Europe/Rome]"), 1, 9, 0, 0)
        assertEquals(9, next.hour)
        assertEquals("+02:00", next.offset.toString())
    }
}
