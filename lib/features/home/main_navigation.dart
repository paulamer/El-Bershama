import 'package:el_bershama/core/constants/app_colors.dart';
import 'package:el_bershama/features/home/home_screen.dart';
import 'package:el_bershama/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:flutter/material.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 3; // Default to Home (RTL)

  final List<Widget> _screens = [
    const Center(child: Text('الحساب')),
    const NotificationsScreen(),
    const Center(child: Text('الأدوية')),
    const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textLight,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'الحساب'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined), label: 'التنبيهات'),
            BottomNavigationBarItem(icon: Icon(Icons.medication_outlined), label: 'الأدوية'),
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'الرئيسية'),
          ],
        ),
      ),
    );
  }
}
