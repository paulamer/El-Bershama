import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:el_bershama/features/medicines/data/models/medicine_model.dart';
import 'package:el_bershama/core/database/hive_helper.dart';
import 'package:el_bershama/core/notifications/notification_helper.dart';
import 'package:el_bershama/features/notifications/data/models/dose_log_model.dart';
import 'package:el_bershama/features/notifications/presentation/providers/notifications_provider.dart';

final medicinesProvider =
    StateNotifierProvider<MedicinesNotifier, List<MedicineModel>>((ref) {
  return MedicinesNotifier(ref);
});

class MedicinesNotifier extends StateNotifier<List<MedicineModel>> {
  final Ref ref;
  MedicinesNotifier(this.ref) : super([]) {
    loadMedicines();
  }

  final _box = Hive.box<MedicineModel>(HiveHelper.medicineBox);

  void loadMedicines() {
    state = _box.values.toList();
  }

  Future<void> addMedicine(MedicineModel medicine) async {
    await _box.put(medicine.id, medicine);
    
    for (int i = 0; i < medicine.doseTimes.length; i++) {
      final timeStr = medicine.doseTimes[i];
      final parts = timeStr.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      
      final now = DateTime.now();
      var scheduledDate = DateTime(now.year, now.month, now.day, hour, minute);
      
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      await NotificationHelper.scheduleNotification(
        id: medicine.id.hashCode + i,
        title: 'حان موعد دواء ${medicine.name}',
        body: 'الجرعة: ${medicine.dosage}',
        scheduledDate: scheduledDate,
      );

      final log = DoseLogModel(
        medicineId: medicine.id,
        medicineName: medicine.name,
        dosage: medicine.dosage,
        scheduledTime: scheduledDate,
      );
      await ref.read(notificationsProvider.notifier).addDoseLog(log);
    }
    
    state = [...state, medicine];
  }

  Future<void> deleteMedicine(String id) async {
    await _box.delete(id);
    await ref.read(notificationsProvider.notifier).deleteLogsForMedicine(id);
    state = state.where((m) => m.id != id).toList();
  }
}
