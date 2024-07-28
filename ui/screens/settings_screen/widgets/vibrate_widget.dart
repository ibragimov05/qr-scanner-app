import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_app/core/utils/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class VibrateWidget extends StatefulWidget {
  const VibrateWidget({super.key});

  @override
  State<VibrateWidget> createState() => _VibrateWidgetState();
}

class _VibrateWidgetState extends State<VibrateWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.ff3D3D3D,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SvgPicture.asset(AppAssets.vibrate),
          Expanded(
            child: Text(
              'Vibrate when scan is done',
              style: AppTextStyles.workSansW500.copyWith(
                color: AppColors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Switch.adaptive(
            value: AppSettings.canVibrate,
            activeColor: AppColors.white,
            activeTrackColor: AppColors.ffFDB623,
            inactiveThumbColor: AppColors.ff333333,
            inactiveTrackColor: AppColors.white,
            onChanged: (value) {
              SharedPreferences.getInstance().then(
                (prefs) => prefs.setBool('can-vibrate', AppSettings.canVibrate),
              );
              AppSettings.canVibrate = !AppSettings.canVibrate;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
