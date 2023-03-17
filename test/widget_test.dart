// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:monthly_alarm_app/data/alarm.dart';
// import 'package:monthly_alarm_app/repository/local_notification.dart';
//
// class MockFlutterLocalNotificationsPlugin extends Mock
//     implements FlutterLocalNotificationsPlugin {}
//
// class MockLocalNotificationRepository extends Mock
//     implements LocalNotificationRepository {}
//
// void main() {
//   group('LocalNotificationRepository', () {
//     late MockLocalNotificationRepository notificationRepository;
//     late MockFlutterLocalNotificationsPlugin mockNotificationsPlugin;
//
//     setUp(() {
//       mockNotificationsPlugin = MockFlutterLocalNotificationsPlugin();
//       notificationRepository = MockLocalNotificationRepository();
//
//       notificationRepository.flutterLocalNotificationsPlugin =
//           mockNotificationsPlugin;
//       registerFallbackValue<AndroidInitializationSettings>(
//           const AndroidInitializationSettings('app_icon'));
//       registerFallbackValue<DarwinInitializationSettings>(
//           const DarwinInitializationSettings(
//             requestAlertPermission: false,
//             requestBadgePermission: false,
//             requestSoundPermission: false,
//           ));
//     });
//
//     test('scheduleMonthlyNotification', () async {
//       // Arrange
//       final alarm = Alarm(
//         alarmId: '1',
//         title: 'Test Alarm',
//         content: 'This is a test alarm.',
//         date: 10, // 예약 날짜
//         time: DateTime(2022, 3, 1, 10, 0), // 예약 시간
//       );
//       final now = DateTime(2022, 3, 1, 9, 0); // 테스트하는 날짜와 시간
//       tz.setLocalLocation(tz.getLocation('Asia/Seoul')); // 타임존 설정
//       final expectedTime = tz.TZDateTime.local(
//           now.year, now.month, 10, alarm.time!.hour, alarm.time!.minute);
//
//       // Act
//       await notificationRepository.scheduleMonthlyNotification(alarm);
//
//       // Assert
//       verify(() => mockNotificationsPlugin.zonedSchedule(
//         1, // alarmId
//         alarm.title,
//         alarm.content,
//         expectedTime,
//         any(),
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//         payload: 'item x',
//         matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
//       ));
//     });
//   });
// }
