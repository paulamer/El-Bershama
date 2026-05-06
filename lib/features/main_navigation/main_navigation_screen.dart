import 'package:flutter/material.dart';
import '../../core/style/app_colors.dart';
import '../home/home_screen.dart';
import '../medicines/presentation/screens/medicines_list_screen.dart';
import '../notifications/presentation/screens/notifications_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MedicinesListScreen(),
    const NotificationsScreen(),
    const Center(child: Text('الحساب')),
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
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'الرئيسية'),
            BottomNavigationBarItem(icon: Icon(Icons.medication_outlined), label: 'الأدوية'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined), label: 'التنبيهات'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'الحساب'),
          ],
        ),
      ),
    );
  }
}
