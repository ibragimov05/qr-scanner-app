import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: const Icon(
        Icons.arrow_back_ios_new,
        color: AppColors.ffFDB623,
      ),
    );
  }
}
