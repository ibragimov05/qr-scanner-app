import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_app/data/models/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class QrCodeInfoWidget extends StatefulWidget {
  final Qr qr;
  final ScreenshotController screenshotController;
  const QrCodeInfoWidget(
      {super.key, required this.qr, required this.screenshotController});

  @override
  State<QrCodeInfoWidget> createState() => _QrCodeInfoWidgetState();
}

class _QrCodeInfoWidgetState extends State<QrCodeInfoWidget> {
  bool _isShrink = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      width: double.infinity,
      height: _isShrink ? 470 : 240,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.ff333333,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.mainLogo,
                      height: 70,
                      width: 70,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        DateFormat('E, d MMM yyyy HH:mm')
                            .format(widget.qr.createdDate),
                        style: AppTextStyles.workSansW400.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                  child: Divider(),
                ),
                Text(
                  widget.qr.data,
                  style: AppTextStyles.workSansW500.copyWith(
                    color: AppColors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                if (_isShrink)
                  Center(
                    child: Screenshot(
                      controller: widget.screenshotController,
                      child: Container(
                        height: MediaQuery.of(context).size.width / 2,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.ffFDB623,
                            width: 4,
                          ),
                        ),
                        child: QrImageView(
                          data: widget.qr.data,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: WidgetStatePropertyAll(
                      AppColors.ffFDB623.withOpacity(0.1)),
                ),
                onPressed: () {
                  setState(() {
                    _isShrink = !_isShrink;
                  });
                },
                child: Text(
                  'Show QR Code',
                  style: AppTextStyles.workSansW500.copyWith(
                    color: AppColors.ffFDB623,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
