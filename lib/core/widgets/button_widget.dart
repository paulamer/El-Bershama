import 'package:flutter/material.dart';
import '../style/app_colors.dart';
import '../style/app_styles.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final bool isLoading;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primary,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(text, style: AppStyles.buttonText),
    );
  }
}
