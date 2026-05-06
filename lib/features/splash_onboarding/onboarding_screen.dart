import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/style/app_colors.dart';
import '../../core/style/app_styles.dart';
import '../../core/widgets/button_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Icon(Icons.notifications_active_outlined, size: 150, color: AppColors.primary),
            const SizedBox(height: 40),
            const Text(
              'مرحبا بك في البرشامة',
              style: AppStyles.heading1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'تذكير بمواعيد الأدوية، متابعة الجرعات وتنظيم أدويتك بسهولة',
              style: AppStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ButtonWidget(
              text: 'ابدأ الآن',
              onPressed: () => context.go('/login'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
