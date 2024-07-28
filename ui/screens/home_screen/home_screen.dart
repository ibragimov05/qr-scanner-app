import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:qr_code_app/core/utils/app_assets.dart';
import 'package:qr_code_app/core/utils/app_colors.dart';
import 'package:qr_code_app/core/utils/app_functions.dart';
import 'package:qr_code_app/core/utils/app_router.dart';
import 'package:qr_code_app/core/utils/app_settings.dart';
import 'package:qr_code_app/core/utils/device_screen.dart';
import 'package:qr_code_app/core/utils/extensions.dart';
import 'package:qr_code_app/logic/cubits/qr_update_cut_out_size/qr_update_cut_out_size_cubit.dart';
import 'package:qr_code_app/ui/screens/home_screen/widgets/tab_box_button.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../logic/cubits/torch/torch_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? _qrViewController;
  double cutOutSize = 200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BlocBuilder<QrUpdateCutOutSizeCubit, double>(
            builder: (context, qrUpdateCutOutSizeState) => GestureDetector(
              onPanUpdate: (details) {
                context.read<QrUpdateCutOutSizeCubit>().onPanUpdate(
                      details: details,
                      context: context,
                    );
              },
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: AppColors.ffFDB623,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: qrUpdateCutOutSizeState,
                ),
              ),
            ),
          ),
          SafeArea(
            child: SizedBox(
              width: DeviceScreen.w(context),
              height: DeviceScreen.h(context),
              child: Column(
                children: [
                  30.h(),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 1.5,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.ff333333.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => _qrViewController!.flipCamera(),
                          child: SvgPicture.asset(AppAssets.camera),
                        ),
                        BlocBuilder<TorchCubit, bool>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                _qrViewController!.toggleFlash();
                                context.read<TorchCubit>().toggleTorch();
                              },
                              child: SvgPicture.asset(
                                state ? AppAssets.flash : AppAssets.flashSlash,
                              ),
                            );
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            _qrViewController!.pauseCamera();
                            Navigator.pushNamed(
                                    context, AppRouter.settingsScreen)
                                .then(
                              (value) => _qrViewController!.resumeCamera(),
                            );
                          },
                          child: SvgPicture.asset(AppAssets.settings),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 70,
        width: MediaQuery.of(context).size.width / 1.5,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.ff333333,
          borderRadius: BorderRadius.circular(8),
          border: const Border(
            bottom: BorderSide(
              color: AppColors.ffFDB623,
              width: 3,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TabBoxButton(
              icoPath: AppAssets.generate,
              buttonLabel: 'Generate',
              onTap: () {
                _qrViewController!.pauseCamera();
                Navigator.pushNamed(context, AppRouter.generateQrCodeScreen)
                    .then(
                  (value) => _qrViewController!.resumeCamera(),
                );
              },
            ),
            // TabBoxButton(
            //   icoPath: AppAssets.search,
            //   buttonLabel: 'Search',
            //   onTap: () {},
            // ),
            TabBoxButton(
              icoPath: AppAssets.history,
              buttonLabel: 'History',
              onTap: () {
                _qrViewController!.pauseCamera();
                Navigator.pushNamed(context, AppRouter.historyScreen).then(
                  (value) => _qrViewController!.resumeCamera(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _qrViewController = controller;

    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      if (AppFunctions.checkIfValidQrCode(scanData.code)) {
        _qrViewController!.pauseCamera();
        if (AppSettings.canVibrate) {
          Vibrate.vibrate();
        }
        Navigator.pushNamed(
          context,
          AppRouter.showQrScreen,
          arguments: scanData.code!,
        ).then(
          (value) => _qrViewController!.resumeCamera(),
        );
      }
    });
  }

  @override
  void dispose() {
    _qrViewController?.dispose();
    super.dispose();
  }
}
