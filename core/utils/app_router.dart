import 'package:flutter/cupertino.dart';
import 'package:qr_code_app/data/models/qr.dart';
import 'package:qr_code_app/ui/screens/generate_qr_code_screen/generate_qr_code_screen.dart';
import 'package:qr_code_app/ui/screens/history_result_qr_screen/history_result_qr_screen.dart';
import 'package:qr_code_app/ui/screens/history_screen/history_screen.dart';
import 'package:qr_code_app/ui/screens/onboarding_screen/onboarding_screen.dart';
import 'package:qr_code_app/ui/screens/settings_screen/settings_screen.dart';
import 'package:qr_code_app/ui/screens/splash_screen/splash_screen.dart';

import '../../ui/screens/home_screen/home_screen.dart';
import '../../ui/screens/show_qr_screen/show_qr_screen.dart';

class AppRouter {
  static const String splashScreen = '/splashScreen';
  static const String onboardingScreen = '/onboardingScreen';
  static const String homeScreen = '/homeScreen';
  static const String generateQrCodeScreen = '/generateQrCodeScreen';
  static const String showQrScreen = '/showQrScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String historyScreen = '/historyScreen';
  static const String historyResultQrScreen = '/historyResultQrScreen';

  static PageRoute _buildPageRoute(Widget widget) =>
      CupertinoPageRoute(builder: (context) => widget);

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouter.homeScreen:
        return _buildPageRoute(const HomeScreen());
      case AppRouter.onboardingScreen:
        return _buildPageRoute(const OnboardingScreen());
      case AppRouter.generateQrCodeScreen:
        return _buildPageRoute(const GenerateQrCodeScreen());
      case AppRouter.showQrScreen:
        final String data = settings.arguments as String;
        return _buildPageRoute(ShowQrScreen(data: data));
      case AppRouter.settingsScreen:
        return _buildPageRoute(const SettingsScreen());
      case AppRouter.historyScreen:
        return _buildPageRoute(const HistoryScreen());
      case AppRouter.historyResultQrScreen:
        final Qr qr = settings.arguments as Qr;
        return _buildPageRoute(HistoryResultQrScreen(qr: qr));
      default:
        return _buildPageRoute(const SplashScreen());
    }
  }
}
