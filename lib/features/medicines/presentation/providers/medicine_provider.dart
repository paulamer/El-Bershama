import 'package:el_bershama/features/medicines/data/models/medicine_model.dart';
import 'package:el_bershama/features/medicines/data/repositories/medicine_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medicine_provider.g.dart';

@riverpod
class Medicines extends _$Medicines {
  @override
  List<MedicineModel> build() {
    final repository = ref.watch(medicineRepositoryProvider);
    return repository.getAllMedicines();
  }

  Future<void> addMedicine(MedicineModel medicine) async {
    final repository = ref.read(medicineRepositoryProvider);
    await repository.saveMedicine(medicine);
    state = repository.getAllMedicines();
  }

  Future<void> deleteMedicine(String id) async {
    final repository = ref.read(medicineRepositoryProvider);
    await repository.deleteMedicine(id);
    state = repository.getAllMedicines();
  }
}
