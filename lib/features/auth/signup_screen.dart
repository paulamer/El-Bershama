import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/style/app_colors.dart';
import '../../core/style/app_styles.dart';
import '../../core/widgets/button_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 80),
                const Text('إنشاء حساب', style: AppStyles.heading1),
                const SizedBox(height: 40),
                _buildField('الاسم الكامل'),
                const SizedBox(height: 20),
                _buildField('البريد الإلكتروني'),
                const SizedBox(height: 20),
                _buildField('كلمة المرور', obscure: true),
                const SizedBox(height: 20),
                _buildField('تأكيد كلمة المرور', obscure: true),
                const SizedBox(height: 40),
                ButtonWidget(
                  text: 'إنشاء حساب',
                  onPressed: () => context.go('/home'),
                ),
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('لديك حساب بالفعل؟ سجل دخولك'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, {bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
