import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:timezone/data/latest.dart';
import 'package:monthly_alarm_app/data/alarm.dart';
import 'package:monthly_alarm_app/repository/local_notification.dart';

Alarm alarm(int day) => Alarm(
      alarmId: '115120000',
      createdAt: DateTime(2026),
      date: day,
      time: DateTime(2026, 1, 1, 9),
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  initializeTimeZones();
  const channel = MethodChannel('dexterous.com/flutter/local_notifications');
  final calls = <MethodCall>[];
  setUp(() async {
    calls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      return true;
    });
    await LocalNotificationRepository.initialize();
    calls.clear();
  });
  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });
  test('main and three reminders are scheduled separately and cancelled together', () async {
    final value = alarm(15).copyWith(
        isOn: true, bfOneDayOn: true, bfThreeDayOn: true, bfOneWeekOn: true);
    await LocalNotificationRepository.scheduleMonthlyNotification(value);
    final schedules = calls.where((c) => c.method == 'zonedSchedule').toList();
    expect(schedules.length, 4);
    expect(schedules.map((c) => (c.arguments as Map)['id']).toSet().length, 4);
    calls.clear();
    await LocalNotificationRepository.offNotification(value.alarmId);
    expect(calls.where((c) => c.method == 'cancel').length, 4);
  });
  test('disabled alarms cancel existing requests without scheduling', () async {
    await LocalNotificationRepository.scheduleMonthlyNotification(alarm(15));
    expect(calls.any((c) => c.method == 'zonedSchedule'), isFalse);
    expect(calls.where((c) => c.method == 'cancel').length, 4);
  });
  test('next month clamps day 31 to February without rolling into March', () {
    expect(nextAlarmOccurrence(alarm(31), DateTime(2026, 1, 31, 10)),
        DateTime(2026, 2, 28, 9));
  });
  test('last day is recalculated for the target month including leap years', () {
    expect(nextAlarmOccurrence(alarm(-1), DateTime(2028, 1, 31, 10)),
        DateTime(2028, 2, 29, 9));
  });
  test('elapsed reminders are moved to a future occurrence', () {
    final occurrence = nextAlarmOccurrence(alarm(1), DateTime(2026, 1, 30),
        advancedDays: 7);
    expect(occurrence, DateTime(2026, 3, 1, 9));
  });
  test('main and advance notifications have separate signed 32-bit IDs', () {
    final ids = [1, 3, 7].map((d) => advancedNotificationId('115120000', d)).toList();
    expect(ids.toSet().length, 3);
    expect(ids.every((id) => id < 0 && id >= -2147483648), isTrue);
  });
}
