import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/style/app_colors.dart';
import '../../core/style/app_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) context.go('/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.medication, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            Text('البرشامة', style: AppStyles.heading1.copyWith(color: Colors.white)),
            const SizedBox(height: 10),
            Text('دوائك... في وقتك', style: AppStyles.bodyLarge.copyWith(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
