import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_styles.dart';
import '../../data/models/medicine_model.dart';
import '../providers/medicines_provider.dart';

class MedicineDetailScreen extends ConsumerWidget {
  final MedicineModel? medicine;
  const MedicineDetailScreen({super.key, this.medicine});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (medicine == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('خطأ')),
        body: const Center(child: Text('الدواء غير موجود')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('تفاصيل الدواء'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _buildHeroCard(),
              const SizedBox(height: 32),
              Row(
                children: [
                  _buildStatCard('مدة الاستخدام', _calculateDuration()),
                  const SizedBox(width: 16),
                  _buildStatCard('الجرعات يومياً', '${medicine!.dailyDoseCount} مرات'),
                ],
              ),
              const SizedBox(height: 32),
              const Align(
                alignment: Alignment.centerRight,
                child: Text('مواعيد الجرعات', style: AppStyles.bodyLarge),
              ),
              const SizedBox(height: 16),
              ...medicine!.doseTimes.map((time) => _buildTimeTile(time)),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  ref.read(medicinesProvider.notifier).deleteMedicine(medicine!.id);
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('حذف الدواء', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _calculateDuration() {
    if (medicine!.endDate == null) return 'مفتوح';
    final days = medicine!.endDate!.difference(medicine!.startDate).inDays;
    return '$days يوم';
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          if (medicine!.imagePath != null && File(medicine!.imagePath!).existsSync())
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                File(medicine!.imagePath!),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            )
          else
            const Icon(Icons.medication, size: 80, color: Colors.white),
          const SizedBox(height: 16),
          Text(medicine!.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(medicine!.dosage, style: const TextStyle(color: Colors.white70, fontSize: 18)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: AppStyles.cardDecoration,
        child: Column(
          children: [
            Text(label, style: AppStyles.bodySmall),
            const SizedBox(height: 8),
            Text(value, style: AppStyles.bodyLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeTile(String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: AppStyles.cardDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(time, style: AppStyles.bodyLarge.copyWith(color: AppColors.primary)),
          const Icon(Icons.check_circle, color: AppColors.primary),
        ],
      ),
    );
  }
}
