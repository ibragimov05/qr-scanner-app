import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_app/core/utils/app_assets.dart';
import 'package:qr_code_app/core/utils/app_colors.dart';
import 'package:qr_code_app/core/utils/app_router.dart';
import 'package:qr_code_app/core/utils/app_text_styles.dart';
import 'package:qr_code_app/data/models/qr.dart';
import 'package:qr_code_app/logic/bloc/hive_qr_scanned/hive_qr_scanned_bloc.dart';

class QrCodeWidget extends StatelessWidget {
  final Qr qr;
  const QrCodeWidget({super.key, required this.qr});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRouter.historyResultQrScreen,
        arguments: qr,
      ),
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.ff333333,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AppAssets.mainLogo,
              height: 50,
              width: 50,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  qr.data,
                  style: AppTextStyles.workSansW400.copyWith(
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<HiveQrScannedBloc>().add(
                          DeleteScannedQrCodeEvent(id: qr.id),
                        );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: AppColors.ffFDB623,
                  ),
                ),
                Text(
                  DateFormat('MMM d, HH:mm').format(qr.createdDate),
                  style: AppTextStyles.workSansW400.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
