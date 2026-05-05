// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dose_log_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoseLogModelAdapter extends TypeAdapter<DoseLogModel> {
  @override
  final int typeId = 2;

  @override
  DoseLogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoseLogModel(
      medicineId: fields[0] as String,
      scheduledTime: fields[1] as DateTime,
      takenAt: fields[2] as DateTime?,
      status: fields[3] as DoseStatus,
    );
  }

  @override
  void write(BinaryWriter writer, DoseLogModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.medicineId)
      ..writeByte(1)
      ..write(obj.scheduledTime)
      ..writeByte(2)
      ..write(obj.takenAt)
      ..writeByte(3)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoseLogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DoseStatusAdapter extends TypeAdapter<DoseStatus> {
  @override
  final int typeId = 1;

  @override
  DoseStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DoseStatus.upcoming;
      case 1:
        return DoseStatus.taken;
      case 2:
        return DoseStatus.missed;
      case 3:
        return DoseStatus.skipped;
      default:
        return DoseStatus.upcoming;
    }
  }

  @override
  void write(BinaryWriter writer, DoseStatus obj) {
    switch (obj) {
      case DoseStatus.upcoming:
        writer.writeByte(0);
        break;
      case DoseStatus.taken:
        writer.writeByte(1);
        break;
      case DoseStatus.missed:
        writer.writeByte(2);
        break;
      case DoseStatus.skipped:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoseStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
