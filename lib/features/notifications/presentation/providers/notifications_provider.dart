import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:el_bershama/features/notifications/data/models/dose_log_model.dart';
import 'package:el_bershama/core/database/hive_helper.dart';

final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, List<DoseLogModel>>((ref) {
  return NotificationsNotifier();
});

class NotificationsNotifier extends StateNotifier<List<DoseLogModel>> {
  NotificationsNotifier() : super([]) {
    loadLogs();
  }

  final _box = Hive.box<DoseLogModel>(HiveHelper.doseLogBox);

  void loadLogs() {
    state = _box.values.toList()..sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
  }

  Future<void> addDoseLog(DoseLogModel log) async {
    await _box.add(log);
    loadLogs();
  }

  Future<void> markAsTaken(DoseLogModel log) async {
    log.isTaken = true;
    log.takenAt = DateTime.now();
    await log.save();
    loadLogs();
  }

  Future<void> deleteLogsForMedicine(String medicineId) async {
    final toDelete = _box.values.where((l) => l.medicineId == medicineId).toList();
    for (var log in toDelete) {
      await log.delete();
    }
    loadLogs();
  }
}
