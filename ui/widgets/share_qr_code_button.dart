import 'package:flutter/material.dart';
import 'package:qr_code_app/logic/services/dependency_injection.dart';
import 'package:qr_code_app/logic/services/qr_code_services.dart';
import 'package:screenshot/screenshot.dart';

import 'helper_button.dart';

class ShareQrCodeButton extends StatefulWidget {
  final String data;
  final ScreenshotController screenshotController;

  const ShareQrCodeButton({
    super.key,
    required this.data,
    required this.screenshotController,
  });

  @override
  State<ShareQrCodeButton> createState() => _ShareQrCodeButtonState();
}

class _ShareQrCodeButtonState extends State<ShareQrCodeButton> {
  final QrCodeServices _qrCodeServices = getIt.get<QrCodeServices>();

  @override
  Widget build(BuildContext context) {
    return HelperButton(
      icon: Icons.share,
      buttonText: 'Share',
      onTap: () => _qrCodeServices.shareQR(
        screenshotController: widget.screenshotController,
        qrData: widget.data,
        context: context,
      ),
    );
  }
}
