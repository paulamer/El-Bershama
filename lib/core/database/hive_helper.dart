import 'package:hive_flutter/hive_flutter.dart';
import '../../features/medicines/data/models/medicine_model.dart';
import '../../features/notifications/data/models/dose_log_model.dart';

class HiveHelper {
  static const String medicineBox = 'medicines_box';
  static const String doseLogBox = 'dose_logs_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(MedicineModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(DoseLogModelAdapter());
    }
    await Hive.openBox<MedicineModel>(medicineBox);
    await Hive.openBox<DoseLogModel>(doseLogBox);
  }
}
