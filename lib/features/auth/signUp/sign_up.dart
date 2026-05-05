import 'package:el_bershama/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.medication, size: 60, color: AppColors.primary),
              const SizedBox(height: 24),
              const Text(
                'إنشاء حساب',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                'أنشئ حساباً جديداً لبدء رحلتك معنا',
                style: TextStyle(color: AppColors.textLight),
              ),
              const SizedBox(height: 32),
              _buildTextField(label: 'الاسم الكامل', icon: Icons.person_outline),
              const SizedBox(height: 16),
              _buildTextField(label: 'البريد الإلكتروني', icon: Icons.email_outlined),
              const SizedBox(height: 16),
              _buildTextField(label: 'كلمة المرور', icon: Icons.lock_outline, isPassword: true),
              const SizedBox(height: 16),
              _buildTextField(label: 'تأكيد كلمة المرور', icon: Icons.lock_outline, isPassword: true),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (v) {}),
                  const Expanded(
                    child: Text('أوافق على الشروط والأحكام وسياسة الخصوصية', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('إنشاء حساب'),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('لديك حساب بالفعل؟ '),
                  GestureDetector(
                    onTap: () => context.go('/login'),
                    child: const Text('سجل دخولك', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required IconData icon, bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.textLight),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
