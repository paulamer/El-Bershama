import 'package:el_bershama/core/theme/app_theme.dart';
import 'package:el_bershama/features/auth/login/login.dart';
import 'package:el_bershama/features/auth/signUp/sign_up.dart';
import 'package:el_bershama/features/home/main_navigation.dart';
import 'package:el_bershama/features/medicines/presentation/screens/add_medicine_screen.dart';
import 'package:el_bershama/features/Onboarding/Onboarding_Screen.dart';
import 'package:el_bershama/features/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
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
      path: '/',
      builder: (context, state) => const MainNavigation(),
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
