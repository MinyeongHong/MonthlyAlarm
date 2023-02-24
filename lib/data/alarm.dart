import 'dart:core';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'alarm.g.dart';

@HiveType(typeId: 0)
class Alarm extends HiveObject {
  @HiveField(0)
  final String alarmId;

  @HiveField(1)
  String? title;

  @HiveField(2)
  bool isOn;

  @HiveField(3)
  String? content;

  @HiveField(4)
  DateTime? time;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  DateTime? updatedAt;

  @HiveField(7)
  int date;

  @HiveField(8)
  bool bfOneDayOn;

  @HiveField(9)
  bool bfThreeDayOn;

  @HiveField(10)
  bool bfOneWeekOn;

  Alarm({
    required this.alarmId,
    this.title,
    this.isOn = false,
    this.content,
    this.time,
    required this.createdAt,
    this.updatedAt,
    required this.date,
    this.bfOneDayOn = false,
    this.bfThreeDayOn = false,
    this.bfOneWeekOn = false,
  });

  Alarm copyWith(
          {String? alarmId,
          String? title,
          bool? isOn,
          String? content,
          DateTime? time,
          DateTime? createdAt,
          DateTime? updatedAt,
          int? date,
          bool? bfOneDayOn,
          bool? bfThreeDayOn,
          bool? bfOneWeekOn}) =>
      Alarm(
          alarmId: alarmId ?? this.alarmId,
          title: title ?? this.title,
          isOn: isOn ?? this.isOn,
          content: content ?? this.content,
          time: time ?? this.time,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          date: date ?? this.date,
          bfOneDayOn: bfOneDayOn ?? this.bfOneDayOn,
          bfThreeDayOn: bfThreeDayOn ?? this.bfThreeDayOn,
          bfOneWeekOn: bfOneWeekOn ?? this.bfOneWeekOn);

  static Alarm emptyAlarm() => Alarm(
      alarmId: const Uuid().v1(),
      title: '',
      content: '',
      isOn: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      date: DateTime.now().day,
      time: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 0, 0, 0),
      bfOneDayOn: false,
      bfThreeDayOn: false,
      bfOneWeekOn: false);
}

// @override
// List<Object?> get props => [alarmId];
//
// factory Alarm.fromJson(Map<String, dynamic> json) {
//   return Alarm(
//     alarmId: json["alarmId"],
//     title: json["title"],
//     isOn: json["isOn"],
//     content: json["content"],
//     time: json["time"],
//     createdAt: json["createdAt"],
//     updatedAt: json["updatedAt"],
//   );
// }
//
// Map<String, dynamic> toJson() {
//   return {
//     "alarmId": alarmId,
//     "title": title,
//     "isOn": isOn,
//     "content": content,
//     "time": time,
//     "createdAt": createdAt,
//     "updatedAt": updatedAt,
//   };
// }
