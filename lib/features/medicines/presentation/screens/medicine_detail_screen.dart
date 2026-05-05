import 'package:el_bershama/core/constants/app_colors.dart';
import 'package:el_bershama/features/medicines/data/models/medicine_model.dart';
import 'package:flutter/material.dart';

class MedicineDetailScreen extends StatelessWidget {
  final MedicineModel medicine;
  const MedicineDetailScreen({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('تفاصيل الدواء'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeroCard(),
              const SizedBox(height: 32),
              Row(
                children: [
                  _buildStatCard('مدة الاستخدام', '5 أيام'),
                  const SizedBox(width: 16),
                  _buildStatCard('عدد الجرعات يومياً', '${medicine.dailyDoseCount} مرات'),
                ],
              ),
              const SizedBox(height: 32),
              const Align(
                alignment: Alignment.centerRight,
                child: Text('مواعيد الجرعات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              ...medicine.doseTimes.map((time) => _buildDoseTimeTile(time)),
              const SizedBox(height: 32),
              const Align(
                alignment: Alignment.centerRight,
                child: Text('معلومات إضافية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              _buildNoteItem('تناول الدواء بعد الأكل'),
              _buildNoteItem('اشرب كمية كافية من الماء'),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                child: const Text('حذف الدواء', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const Icon(Icons.medication, size: 60, color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          Text(medicine.name, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          Text(medicine.dosage, style: TextStyle(color: Colors.white.withOpacity(0.8))),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text(label, style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildDoseTimeTile(String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 18)),
              const Text('بعد الإفطار', style: TextStyle(color: AppColors.textLight, fontSize: 12)),
            ],
          ),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: const Icon(Icons.check, size: 16, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteItem(String text) {
    return Row(
      children: [
        const Icon(Icons.circle, size: 6, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: AppColors.textLight)),
      ],
    );
  }
}
