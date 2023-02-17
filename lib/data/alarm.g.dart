// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlarmAdapter extends TypeAdapter<Alarm> {
  @override
  final int typeId = 0;

  @override
  Alarm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Alarm(
      alarmId: fields[0] as String,
      title: fields[1] as String?,
      isOn: fields[2] as bool,
      content: fields[3] as String?,
      time: fields[4] as DateTime?,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime?,
      date: fields[7] as int,
      bfOneDayOn: fields[8] as bool,
      bfThreeDayOn: fields[9] as bool,
      bfOneWeekOn: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Alarm obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.alarmId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.isOn)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.date)
      ..writeByte(8)
      ..write(obj.bfOneDayOn)
      ..writeByte(9)
      ..write(obj.bfThreeDayOn)
      ..writeByte(10)
      ..write(obj.bfOneWeekOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
