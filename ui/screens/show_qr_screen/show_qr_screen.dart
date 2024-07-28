import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/core/utils/app_colors.dart';
import 'package:qr_code_app/logic/bloc/hive_qr_scanned/hive_qr_scanned_bloc.dart';
import 'package:qr_code_app/ui/screens/show_qr_screen/widgets/go_to_url_widget.dart';
import 'package:qr_code_app/ui/widgets/helper_button.dart';
import 'package:qr_code_app/ui/widgets/arrow_back_button.dart';
import 'package:qr_code_app/ui/widgets/share_qr_code_button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../core/utils/app_functions.dart';
import '../../../logic/services/dependency_injection.dart';
import '../../../logic/services/qr_code_services.dart';

class ShowQrScreen extends StatefulWidget {
  final String _data;
  const ShowQrScreen({super.key, required String data}) : _data = data;

  @override
  State<ShowQrScreen> createState() => _ShowQrScreenState();
}

class _ShowQrScreenState extends State<ShowQrScreen> {
  final QrCodeServices _qrCodeServices = getIt.get<QrCodeServices>();
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    context.read<HiveQrScannedBloc>().add(
          AddScannedQrCodeEvent(data: widget._data),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ff525252,
      appBar: AppBar(
        title: const Text('QR Code'),
        leading: const ArrowBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GoToUrlWidget(data: widget._data),
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
                  data: widget._data,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ShareQrCodeButton(
                    data: widget._data,
                    screenshotController: _screenshotController,
                  ),
                  HelperButton(
                    icon: Icons.save,
                    buttonText: 'Save',
                    onTap: () async {
                      final bool isSucces =
                          await _qrCodeServices.generateAndSaveQRCode(
                        screenshotController: _screenshotController,
                        data: widget._data,
                      );  
                      if (context.mounted) {
                        if (isSucces) {
                          Navigator.pop(context);
                          AppFunctions.showSnackBar(
                              'QR Code saved to gallery', context);
                        } else {
                          Navigator.pop(context);
                          AppFunctions.showSnackBar(
                              'Something went wrong! Try again, please.',
                              context);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
