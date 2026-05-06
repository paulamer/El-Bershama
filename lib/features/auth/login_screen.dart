import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/style/app_colors.dart';
import '../../core/style/app_styles.dart';
import '../../core/widgets/button_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('تسجيل الدخول', style: AppStyles.heading1),
              const SizedBox(height: 40),
              TextField(
                decoration: InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
              const SizedBox(height: 40),
              ButtonWidget(
                text: 'دخول',
                onPressed: () => context.go('/home'),
              ),
              TextButton(
                onPressed: () => context.go('/signup'),
                child: const Text('ليس لديك حساب؟ إنشاء حساب جديد'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
