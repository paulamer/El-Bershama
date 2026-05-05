import 'package:el_bershama/core/theme/app_theme.dart';
import 'package:el_bershama/features/medicines/presentation/screens/add_medicine_screen.dart';
import 'package:el_bershama/features/medicines/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/add-medicine',
      builder: (context, state) => const AddMedicineScreen(),
    ),
  ],
);

class MedicineApp extends StatelessWidget {
  const MedicineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'El Bershama',
      theme: AppTheme.lightTheme,
      routerConfig: _router,
    );
  }
}
