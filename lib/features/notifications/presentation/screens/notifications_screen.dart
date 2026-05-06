import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:el_bershama/core/style/app_colors.dart';
import 'package:el_bershama/core/style/app_styles.dart';
import 'package:el_bershama/features/notifications/presentation/providers/notifications_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('التنبيهات'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'القادمة'),
              Tab(text: 'السابقة'),
            ],
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textLight,
            indicatorColor: AppColors.primary,
          ),
        ),
        body: const TabBarView(
          children: [
            NotificationList(isPast: false),
            NotificationList(isPast: true),
          ],
        ),
      ),
    );
  }
}

class NotificationList extends ConsumerWidget {
  final bool isPast;
  const NotificationList({super.key, required this.isPast});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(notificationsProvider);
    final filtered = logs.where((l) => l.isTaken == isPast).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: filtered.isEmpty
          ? Center(child: Text(isPast ? 'لا توجد تنبيهات سابقة' : 'لا توجد تنبيهات قادمة'))
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final log = filtered[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: AppStyles.cardDecoration,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time, color: AppColors.primary),
                          const SizedBox(width: 12),
                          Text('${log.scheduledTime.hour}:${log.scheduledTime.minute.toString().padLeft(2, '0')}', style: AppStyles.bodyLarge),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(log.medicineName, style: AppStyles.bodyLarge),
                              Text(log.dosage, style: AppStyles.bodySmall),
                            ],
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.medication, color: AppColors.primary, size: 30),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (!log.isTaken)
                        ElevatedButton(
                          onPressed: () => ref.read(notificationsProvider.notifier).markAsTaken(log),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            minimumSize: const Size(double.infinity, 44),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('تأكيد عند أخذ الجرعة', style: TextStyle(color: Colors.white)),
                        )
                      else
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text('تم أخذ الجرعة', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
