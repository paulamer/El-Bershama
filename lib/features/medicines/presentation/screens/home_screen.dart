import 'package:el_bershama/core/constants/app_colors.dart';
import 'package:el_bershama/features/medicines/data/models/medicine_model.dart';
import 'package:el_bershama/features/medicines/presentation/providers/medicine_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicines = ref.watch(medicinesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('أدوية اليوم'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle, color: AppColors.primary, size: 30),
            onPressed: () => context.push('/add-medicine'),
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: medicines.isEmpty
            ? _buildEmptyState()
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: medicines.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final medicine = medicines[index];
                  return _buildMedicineCard(context, medicine);
                },
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.medication_liquid, size: 80, color: AppColors.textLight),
          const SizedBox(height: 16),
          const Text('لا توجد أدوية مضافة بعد', style: TextStyle(fontSize: 18, color: AppColors.textLight)),
        ],
      ),
    );
  }

  Widget _buildMedicineCard(BuildContext context, MedicineModel medicine) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.medication, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(medicine.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('${medicine.dosage} - ${medicine.dailyDoseCount} مرات يومياً',
                    style: const TextStyle(color: AppColors.textLight)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textLight),
        ],
      ),
    );
  }
}
