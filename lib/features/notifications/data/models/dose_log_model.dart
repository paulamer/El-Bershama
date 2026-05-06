import 'package:hive/hive.dart';

part 'dose_log_model.g.dart';

@HiveType(typeId: 1)
class DoseLogModel extends HiveObject {
  @HiveField(0)
  final String medicineId;
  @HiveField(1)
  final String medicineName;
  @HiveField(2)
  final String dosage;
  @HiveField(3)
  final DateTime scheduledTime;
  @HiveField(4)
  DateTime? takenAt;
  @HiveField(5)
  bool isTaken;

  DoseLogModel({
    required this.medicineId,
    required this.medicineName,
    required this.dosage,
    required this.scheduledTime,
    this.takenAt,
    this.isTaken = false,
  });
}
