import 'package:flutter/material.dart';
import 'package:qr_code_app/core/utils/app_colors.dart';
import 'package:qr_code_app/ui/screens/settings_screen/widgets/vibrate_widget.dart';
import 'package:qr_code_app/ui/widgets/arrow_back_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ff525252,
      appBar: AppBar(
        title: const Text('Settings'),
        leading: const ArrowBackButton(),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
        children: const <Widget>[
          VibrateWidget(),
        ],
      ),
    );
  }
}
