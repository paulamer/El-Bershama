import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_styles.dart';
import '../providers/medicines_provider.dart';

class MedicinesListScreen extends ConsumerWidget {
  const MedicinesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicines = ref.watch(medicinesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('أدويتي'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: medicines.isEmpty
            ? const Center(child: Text('قائمة الأدوية فارغة'))
            : ListView.builder(
                padding: const EdgeInsets.all(20),
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
                          const Icon(Icons.medication, color: AppColors.primary, size: 30),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(med.name, style: AppStyles.bodyLarge),
                                Text(med.dosage, style: AppStyles.bodySmall),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textLight),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
