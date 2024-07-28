import 'package:flutter/material.dart';
import 'package:qr_code_app/core/utils/app_colors.dart';
import 'package:qr_code_app/core/utils/app_text_styles.dart';

class AppFunctions {
  static bool checkIfValidQrCode(String? data) {
    if (data == null || data.trim().isEmpty) {
      return false;
    }
    return true;
  }

  static void showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextStyles.workSansW500.copyWith(
            color: AppColors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
