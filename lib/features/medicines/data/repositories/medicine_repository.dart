import 'package:el_bershama/features/medicines/data/models/medicine_model.dart';
import 'package:el_bershama/features/medicines/data/models/dose_log_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medicine_repository.g.dart';

class MedicineRepository {
  static const String medicineBoxName = 'medicines';
  static const String doseLogBoxName = 'dose_logs';

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(MedicineModelAdapter());
    if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(DoseStatusAdapter());
    if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(DoseLogModelAdapter());

    await Hive.openBox<MedicineModel>(medicineBoxName);
    await Hive.openBox<DoseLogModel>(doseLogBoxName);
  }

  Box<MedicineModel> get _medicineBox => Hive.box<MedicineModel>(medicineBoxName);
  Box<DoseLogModel> get _doseLogBox => Hive.box<DoseLogModel>(doseLogBoxName);

  List<MedicineModel> getAllMedicines() => _medicineBox.values.toList();

  Future<void> saveMedicine(MedicineModel medicine) async {
    await _medicineBox.put(medicine.id, medicine);
  }

  Future<void> deleteMedicine(String id) async {
    await _medicineBox.delete(id);
    // Cleanup logs associated with this medicine
    final logsToRemove = _doseLogBox.values.where((log) => log.medicineId == id).map((log) => log.id);
    await _doseLogBox.deleteAll(logsToRemove);
  }

  List<DoseLogModel> getDoseLogs(String medicineId) {
    return _doseLogBox.values.where((log) => log.medicineId == medicineId).toList();
  }

  Future<void> saveDoseLog(DoseLogModel log) async {
    await _doseLogBox.put(log.id, log);
  }

  List<DoseLogModel> getDosesForDate(DateTime date) {
    return _doseLogBox.values.where((log) {
      return log.scheduledTime.year == date.year &&
          log.scheduledTime.month == date.month &&
          log.scheduledTime.day == date.day;
    }).toList();
  }
}

@riverpod
MedicineRepository medicineRepository(MedicineRepositoryRef ref) {
  return MedicineRepository();
}
