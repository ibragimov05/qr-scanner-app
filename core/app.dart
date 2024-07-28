import 'package:flutter/material.dart';
import 'package:qr_code_app/core/utils/app_colors.dart';
import 'package:qr_code_app/core/utils/app_router.dart';
import 'package:qr_code_app/core/utils/app_settings.dart';
import 'package:qr_code_app/core/utils/app_text_styles.dart';
import 'package:qr_code_app/ui/screens/home_screen/home_screen.dart';
import 'package:qr_code_app/ui/screens/onboarding_screen/onboarding_screen.dart';
import 'package:qr_code_app/ui/screens/splash_screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Future<bool> _didUserSeeOnboarding() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    AppSettings.canVibrate = sharedPreferences.getBool('can-vibrate') ?? false;
    await Future.delayed(const Duration(seconds: 2));
    return sharedPreferences.getBool('did-user-see-onboarding') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.ff525252,
          titleTextStyle: AppTextStyles.workSansW500.copyWith(
            fontSize: 22,
            color: AppColors.ffFDB623,
          ),
          centerTitle: true,
        ),
      ),
      home: FutureBuilder(
        future: _didUserSeeOnboarding(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.hasError ||
              snapshot.data == null) {
            return const SplashScreen();
          } else {
            if (!snapshot.data!) {
              return const OnboardingScreen();
            } else {
              return const HomeScreen();
            }
          }
        },
      ),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
