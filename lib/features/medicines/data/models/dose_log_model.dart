import 'package:hive/hive.dart';

part 'dose_log_model.g.dart';

@HiveType(typeId: 1)
enum DoseStatus {
  @HiveField(0)
  upcoming,
  @HiveField(1)
  taken,
  @HiveField(2)
  missed,
  @HiveField(3)
  skipped
}

@HiveType(typeId: 2)
class DoseLogModel extends HiveObject {
  @HiveField(0)
  final String medicineId;

  @HiveField(1)
  final DateTime scheduledTime;

  @HiveField(2)
  DateTime? takenAt;

  @HiveField(3)
  DoseStatus status;

  DoseLogModel({
    required this.medicineId,
    required this.scheduledTime,
    this.takenAt,
    this.status = DoseStatus.upcoming,
  });

  String get id => '${medicineId}_${scheduledTime.toIso8601String()}';
}
