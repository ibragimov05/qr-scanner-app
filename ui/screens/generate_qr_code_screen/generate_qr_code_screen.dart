import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_app/core/utils/app_assets.dart';
import 'package:qr_code_app/core/utils/app_colors.dart';
import 'package:qr_code_app/core/utils/device_screen.dart';
import 'package:qr_code_app/core/utils/app_text_styles.dart';
import 'package:qr_code_app/ui/screens/generate_qr_code_screen/widgets/custom_text_field.dart';
import 'package:qr_code_app/ui/screens/generate_qr_code_screen/widgets/show_qr_dialog.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class GenerateQrCodeScreen extends StatefulWidget {
  const GenerateQrCodeScreen({super.key});

  @override
  State<GenerateQrCodeScreen> createState() => _GenerateQrCodeScreenState();
}

class _GenerateQrCodeScreenState extends State<GenerateQrCodeScreen> {
  final TextEditingController _qrCodeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ff3D3D3D,
      appBar: AppBar(
        backgroundColor: AppColors.ff3D3D3D,
        title: Text(
          'Generate QR code',
          style: AppTextStyles.workSansW500.copyWith(
            color: AppColors.white,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.ffFDB623,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Container(
            width: double.infinity,
            height: DeviceScreen.h(context) / 2.2,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.ff333333,
              border: const Border(
                bottom: BorderSide(
                  color: AppColors.ffFDB623,
                  width: 3,
                ),
                top: BorderSide(
                  color: AppColors.ffFDB623,
                  width: 3,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(
                  AppAssets.mainLogo,
                  height: 100,
                  width: 100,
                ),
                CustomTextField(qrCodeTextController: _qrCodeTextController),
                ZoomTapAnimation(
                  onTap: () {
                    if (_qrCodeTextController.text.trim().isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ShowQrDialog(
                            userInput: _qrCodeTextController.text,
                          );
                        },
                      ).then(
                        (value) => _qrCodeTextController.clear(),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fill the field'),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: DeviceScreen.w(context) / 2,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.ffFDB623,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Generate QR code',
                        style: AppTextStyles.workSansW500.copyWith(
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _qrCodeTextController.dispose();
    super.dispose();
  }
}
