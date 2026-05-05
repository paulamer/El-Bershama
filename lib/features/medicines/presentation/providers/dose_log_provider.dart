import 'package:el_bershama/features/medicines/data/models/dose_log_model.dart';
import 'package:el_bershama/features/medicines/data/repositories/medicine_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dose_log_provider.g.dart';

@riverpod
class DoseLogs extends _$DoseLogs {
  @override
  List<DoseLogModel> build() {
    final repository = ref.watch(medicineRepositoryProvider);
    return repository.getDosesForDate(DateTime.now());
  }

  Future<void> updateDoseStatus(DoseLogModel log, DoseStatus status) async {
    final repository = ref.read(medicineRepositoryProvider);
    log.status = status;
    if (status == DoseStatus.taken) {
      log.takenAt = DateTime.now();
    }
    await repository.saveDoseLog(log);
    state = repository.getDosesForDate(DateTime.now());
  }

  void refresh() {
    final repository = ref.read(medicineRepositoryProvider);
    state = repository.getDosesForDate(DateTime.now());
  }
}
