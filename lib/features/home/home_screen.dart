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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProgressCard(),
                    const SizedBox(height: 24),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('مواعيد اليوم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.textLight),
                      ],
                    ),
                    const SizedBox(height: 16),
                    medicines.isEmpty ? _buildEmptyState() : _buildMedicineList(medicines),
                    const SizedBox(height: 24),
                    _buildAddButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.notifications_none, color: AppColors.primary),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('أهلاً بك', style: TextStyle(color: AppColors.textLight, fontSize: 14)),
              Text('علي محمد', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('لا تنس دوائك', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('نحن هنا لمساعدتك على\nتذكر مواعيد أدويتك', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
              ],
            ),
          ),
          Image.asset('images/bersham.png', width: 80, errorBuilder: (_, __, ___) => const Icon(Icons.medication, size: 60, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 40),
          Icon(Icons.medication_liquid_outlined, size: 80, color: AppColors.primary.withOpacity(0.2)),
          const SizedBox(height: 16),
          const Text('لا توجد مواعيد اليوم', style: TextStyle(color: AppColors.textLight)),
        ],
      ),
    );
  }

  Widget _buildMedicineList(List<MedicineModel> medicines) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: medicines.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final med = medicines[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: AppColors.background, shape: BoxShape.circle),
                child: const Icon(Icons.medication, color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(med.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('${med.dosage}', style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(med.doseTimes.first, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                      const SizedBox(width: 4),
                      const Icon(Icons.access_time, size: 14, color: AppColors.primary),
                    ],
                  ),
                  const Text('قرص بعد الإفطار', style: TextStyle(color: AppColors.textLight, fontSize: 10)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.push('/add-medicine'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_circle_outline, color: Colors.white),
          SizedBox(width: 10),
          Text('إضافة دواء جديد', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
