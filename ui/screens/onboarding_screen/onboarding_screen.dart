import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_app/core/utils/app_assets.dart';
import 'package:qr_code_app/core/utils/app_router.dart';
import 'package:qr_code_app/core/utils/app_text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ffFDB623,
      body: Center(
        child: SvgPicture.asset(AppAssets.mainLogo),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 3,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: AppColors.ff333333,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Get started',
              style: AppTextStyles.workSansW400.copyWith(
                color: AppColors.white,
                fontSize: 25,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Text(
                'Go and enjoy our features for free and make your life easy with us.',
                style: AppTextStyles.workSansW400.copyWith(
                  color: AppColors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            GestureDetector(
              onTap: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setBool('did-user-see-onboarding', true);
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRouter.homeScreen,
                    (route) => true,
                  );
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.ffFDB623,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Text(
                      'Let\'s go',
                      style: AppTextStyles.workSansW600.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
