import 'package:flutter/material.dart';
import 'package:qr_code_app/core/utils/app_assets.dart';
import 'package:qr_code_app/core/utils/app_colors.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ffFDB623,
      body: Center(
        child: Lottie.asset(
          AppAssets.loading,
          height: MediaQuery.of(context).size.width / 3,
          width: MediaQuery.of(context).size.width / 3,
        ),
      ),
    );
  }
}
