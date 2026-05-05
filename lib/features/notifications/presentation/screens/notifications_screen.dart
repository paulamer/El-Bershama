import 'package:el_bershama/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1, // Start on 'Upcoming' (RTL right tab)
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('التنبيهات'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: AppColors.textLight,
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: 'السابقة'),
                    Tab(text: 'القادمة'),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('لا توجد تنبيهات سابقة')),
            UpcomingNotificationsTab(),
          ],
        ),
      ),
    );
  }
}

class UpcomingNotificationsTab extends StatelessWidget {
  const UpcomingNotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Align(
          alignment: Alignment.centerRight,
          child: Text('اليوم - 24 مايو', style: TextStyle(color: AppColors.textLight, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 16),
        _buildNotificationCard(
          time: '8:00 AM',
          name: 'باراسيتامول',
          dose: '500 مجم',
          note: 'بعد الإفطار',
          isTaken: true,
        ),
        const SizedBox(height: 12),
        _buildNotificationCard(
          time: '2:00 PM',
          name: 'أوجمنتين',
          dose: '1 جم',
          note: 'بعد الغداء',
          isTaken: true,
        ),
        const SizedBox(height: 12),
        _buildNotificationCard(
          time: '8:00 PM',
          name: 'فيتامين د',
          dose: '1000 وحدة',
          note: 'بعد العشاء',
          isTaken: false,
        ),
      ],
    );
  }

  Widget _buildNotificationCard({
    required String time,
    required String name,
    required String dose,
    required String note,
    required bool isTaken,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(time, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 18)),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(dose, style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
                  Text(note, style: const TextStyle(color: AppColors.textLight, fontSize: 10)),
                ],
              ),
              const SizedBox(width: 16),
              const Icon(Icons.circle, size: 40, color: AppColors.background), // Placeholder for med icon
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: isTaken ? null : () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: isTaken ? AppColors.background : AppColors.primary,
              foregroundColor: isTaken ? AppColors.primary : Colors.white,
              elevation: 0,
              minimumSize: const Size(double.infinity, 44),
            ),
            child: Text(isTaken ? 'تم أخذ الجرعة' : 'تأكيد عند أخذ الجرعة'),
          ),
        ],
      ),
    );
  }
}
