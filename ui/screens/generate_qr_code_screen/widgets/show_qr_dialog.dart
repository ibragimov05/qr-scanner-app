import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/core/utils/app_colors.dart';
import 'package:qr_code_app/core/utils/app_functions.dart';
import 'package:qr_code_app/core/utils/app_text_styles.dart';
import 'package:qr_code_app/logic/bloc/hive_qr_created/hive_qr_created_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../logic/services/dependency_injection.dart';
import '../../../../logic/services/qr_code_services.dart';

class ShowQrDialog extends StatefulWidget {
  final String userInput;
  const ShowQrDialog({
    super.key,
    required this.userInput,
  });

  @override
  State<ShowQrDialog> createState() => _ShowQrDialogState();
}

class _ShowQrDialogState extends State<ShowQrDialog> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final QrCodeServices _saveQrCode = getIt.get<QrCodeServices>();
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'QR Code',
        style: AppTextStyles.workSansW500.copyWith(
          color: AppColors.white,
        ),
      ),
      backgroundColor: AppColors.ff525252,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Screenshot(
            controller: _screenshotController,
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
                data: widget.userInput,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(
              AppColors.red.withOpacity(0.1),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Close',
            style: AppTextStyles.workSansW500.copyWith(
              color: AppColors.red,
            ),
          ),
        ),
        TextButton(
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(
              AppColors.ffFDB623.withOpacity(0.1),
            ),
          ),
          onPressed: () {
            _saveQrCode
                .generateAndSaveQRCode(
              screenshotController: _screenshotController,
              data: widget.userInput,
              context: context,
            )
                .then(
              (value) {
                if (value) {
                  AppFunctions.showSnackBar(
                    'QR Code saved to gallery',
                    context,
                  );
                }
              },
            );
            context.read<HiveQrCreatedBloc>().add(
                  AddCreatedQrCodeEvent(data: widget.userInput),
                );
            Navigator.pop(context);
          },
          child: Text(
            'Save to gallery',
            style: AppTextStyles.workSansW500.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
