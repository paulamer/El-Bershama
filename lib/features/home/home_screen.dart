import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/style/app_colors.dart';
import '../../core/style/app_styles.dart';
import '../medicines/presentation/providers/medicines_provider.dart';
import '../medicines/presentation/screens/medicine_detail_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicines = ref.watch(medicinesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildHeroBanner(),
              const SizedBox(height: 32),
              const Text('مواعيد اليوم', style: AppStyles.heading2),
              const SizedBox(height: 16),
              medicines.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Text('لا توجد مواعيد مضافة بعد', style: AppStyles.bodyMedium),
                      ),
                    )
                  : _buildScheduleList(context, medicines, ref),
              const SizedBox(height: 32),
              _buildAddButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.notifications_none, color: AppColors.primary, size: 30),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('أهلاً بك', style: AppStyles.bodyMedium),
            Text('علي محمد', style: AppStyles.bodyLarge),
          ],
        ),
        const CircleAvatar(
          backgroundColor: AppColors.accent,
          child: Icon(Icons.person, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('لا تنس دوائك', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('نحن هنا لمساعدتك على تذكر مواعيد أدويتك', style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          const Icon(Icons.medication, size: 60, color: Colors.white24),
        ],
      ),
    );
  }

  Widget _buildScheduleList(BuildContext context, List medicines, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: medicines.length,
      itemBuilder: (context, index) {
        final med = medicines[index];
        return GestureDetector(
          onTap: () {
            context.push('/medicine-detail/${med.id}', extra: med);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: AppStyles.cardDecoration,
            child: Row(
              children: [
                const Icon(Icons.circle, size: 12, color: AppColors.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(med.name, style: AppStyles.bodyLarge),
                      Text('${med.dosage}', style: AppStyles.bodySmall),
                    ],
                  ),
                ),
                Text(med.doseTimes.first, style: AppStyles.bodyLarge.copyWith(color: AppColors.primary)),
              ],
            ),
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
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: const Text('إضافة دواء جديد', style: AppStyles.buttonText),
    );
  }
}
