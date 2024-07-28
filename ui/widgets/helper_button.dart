import 'package:flutter/material.dart';
import 'package:qr_code_app/core/utils/app_colors.dart';
import 'package:qr_code_app/core/utils/app_text_styles.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HelperButton extends StatelessWidget {
  final IconData icon;
  final String buttonText;
  final void Function() onTap;
  const HelperButton({
    super.key,
    required this.icon,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZoomTapAnimation(
          onTap: onTap,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: AppColors.ffFDB623,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 30),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          buttonText,
          style: AppTextStyles.workSansW500.copyWith(
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
