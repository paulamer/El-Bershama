import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:el_bershama/core/style/app_colors.dart';
import 'package:el_bershama/features/splash_onboarding/splash_screen.dart';
import 'package:el_bershama/features/splash_onboarding/onboarding_screen.dart';
import 'package:el_bershama/features/auth/login_screen.dart';
import 'package:el_bershama/features/auth/signup_screen.dart';
import 'package:el_bershama/features/main_navigation/main_navigation_screen.dart';
import 'package:el_bershama/features/medicines/presentation/screens/add_medicine_screen.dart';
import 'package:el_bershama/features/medicines/presentation/screens/medicine_detail_screen.dart';
import 'package:el_bershama/features/medicines/data/models/medicine_model.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainNavigationScreen(),
    ),
    GoRoute(
      path: '/add-medicine',
      builder: (context, state) => const AddMedicineScreen(),
    ),
    GoRoute(
      path: '/medicine-detail/:id',
      builder: (context, state) {
        final medicine = state.extra as MedicineModel?;
        return MedicineDetailScreen(medicine: medicine);
      },
    ),
  ],
);

class MedicineApp extends StatelessWidget {
  const MedicineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'البرشامة',
      theme: ThemeData(
        fontFamily: 'Cairo',
        useMaterial3: true,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      routerConfig: _router,
    );
  }
}
