// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dose_log_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoseLogModelAdapter extends TypeAdapter<DoseLogModel> {
  @override
  final int typeId = 1;

  @override
  DoseLogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoseLogModel(
      medicineId: fields[0] as String,
      medicineName: fields[1] as String,
      dosage: fields[2] as String,
      scheduledTime: fields[3] as DateTime,
      takenAt: fields[4] as DateTime?,
      isTaken: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DoseLogModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.medicineId)
      ..writeByte(1)
      ..write(obj.medicineName)
      ..writeByte(2)
      ..write(obj.dosage)
      ..writeByte(3)
      ..write(obj.scheduledTime)
      ..writeByte(4)
      ..write(obj.takenAt)
      ..writeByte(5)
      ..write(obj.isTaken);
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
