import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'medicine_model.g.dart';

@HiveType(typeId: 0)
class MedicineModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String dosage;

  @HiveField(3)
  final int dailyDoseCount;

  @HiveField(4)
  final List<String> doseTimes; // Stores TimeOfDay as "HH:mm"

  @HiveField(5)
  final DateTime startDate;

  @HiveField(6)
  final DateTime? endDate;

  @HiveField(7)
  final String? imagePath;

  @HiveField(8)
  final bool isActive;

  MedicineModel({
    String? id,
    required this.name,
    required this.dosage,
    required this.dailyDoseCount,
    required this.doseTimes,
    required this.startDate,
    this.endDate,
    this.imagePath,
    this.isActive = true,
  }) : id = id ?? const Uuid().v4();
}
