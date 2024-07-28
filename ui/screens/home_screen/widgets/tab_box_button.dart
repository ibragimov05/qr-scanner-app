import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_app/core/utils/app_colors.dart';
import 'package:qr_code_app/core/utils/app_text_styles.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class TabBoxButton extends StatelessWidget {
  final String icoPath;
  final String buttonLabel;
  final void Function() onTap;

  const TabBoxButton({
    super.key,
    required this.icoPath,
    required this.buttonLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(icoPath),
          const Spacer(),
          Text(
            buttonLabel,
            style: AppTextStyles.workSansW500.copyWith(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
