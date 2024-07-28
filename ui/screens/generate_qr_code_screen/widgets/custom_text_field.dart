import 'package:flutter/material.dart';
import 'package:qr_code_app/core/utils/app_colors.dart';
import 'package:qr_code_app/core/utils/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController qrCodeTextController;
  const CustomTextField({super.key, required this.qrCodeTextController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: qrCodeTextController,
      style: AppTextStyles.workSansW500.copyWith(
        color: AppColors.white,
      ),
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.ffFDB623,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.ffFDB623,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.ffFDB623,
            width: 2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.ffFDB623,
            width: 2,
          ),
        ),
      ),
    );
  }
}
