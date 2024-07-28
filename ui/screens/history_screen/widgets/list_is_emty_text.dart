import 'package:flutter/material.dart';
import 'package:qr_code_app/core/utils/app_colors.dart';
import 'package:qr_code_app/core/utils/app_text_styles.dart';

class ListIsEmtyText extends StatelessWidget {
  final String historyName;
  const ListIsEmtyText({super.key, required this.historyName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'You do not have $historyName QR Codes',
        style: AppTextStyles.workSansW600.copyWith(
          color: AppColors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
