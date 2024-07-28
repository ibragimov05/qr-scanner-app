import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_app/core/utils/app_colors.dart';
import 'package:qr_code_app/core/utils/app_functions.dart';
import 'package:qr_code_app/data/models/qr.dart';
import 'package:qr_code_app/ui/screens/history_result_qr_screen/widgets/qr_code_info_widget.dart';
import 'package:qr_code_app/ui/widgets/helper_button.dart';
import 'package:qr_code_app/ui/widgets/arrow_back_button.dart';
import 'package:screenshot/screenshot.dart';

import '../../widgets/share_qr_code_button.dart';

class HistoryResultQrScreen extends StatefulWidget {
  final Qr qr;
  const HistoryResultQrScreen({super.key, required this.qr});

  @override
  State<HistoryResultQrScreen> createState() => _HistoryResultQrScreenState();
}

class _HistoryResultQrScreenState extends State<HistoryResultQrScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ff525252,
      appBar: AppBar(
        title: const Text('Result'),
        leading: const ArrowBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            QrCodeInfoWidget(
              qr: widget.qr,
              screenshotController: _screenshotController,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShareQrCodeButton(
                  data: widget.qr.data,
                  screenshotController: _screenshotController,
                ),
                HelperButton(
                  icon: Icons.copy,
                  buttonText: 'Copy',
                  onTap: () {
                    FlutterClipboard.copy(widget.qr.data);
                    AppFunctions.showSnackBar('Copied to clipboard', context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
