import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/core/utils/app_colors.dart';
import 'package:qr_code_app/logic/bloc/hive_qr_scanned/hive_qr_scanned_bloc.dart';
import 'package:qr_code_app/ui/screens/history_screen/widgets/list_is_emty_text.dart';
import 'package:qr_code_app/ui/screens/history_screen/widgets/qr_code_widget.dart';
import 'package:qr_code_app/ui/screens/history_screen/widgets/tab_item.dart';
import 'package:qr_code_app/ui/widgets/arrow_back_button.dart';

import '../../../logic/bloc/hive_qr_created/hive_qr_created_bloc.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistortScreenState();
}

class _HistortScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.ff525252,
        appBar: AppBar(
          title: const Text('History'),
          leading: const ArrowBackButton(),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(
              kTextTabBarHeight,
            ),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: kToolbarHeight,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.ff333333,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: AppColors.ffFDB623,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  dividerColor: Colors.transparent,
                  dividerHeight: 0.1,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  tabs: const [
                    TabItem(title: 'Scan'),
                    TabItem(title: 'Create'),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            //! scanned qr codes bloc
            BlocBuilder<HiveQrScannedBloc, HiveScannedQrStates>(
              bloc: context.read<HiveQrScannedBloc>()
                ..add(GetScannedQrCodesEvent()),
              buildWhen: (previous, current) =>
                  current != previous &&
                  (current is LoadedHiveScannedQrState ||
                      current is ErrorHiveScannedQrState),
              builder: (context, state) {
                if (state is LoadingHiveScannedQrState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedHiveScannedQrState) {
                  return state.qrCodes.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.qrCodes.length,
                          itemBuilder: (context, index) => QrCodeWidget(
                            qr: state.qrCodes[index],
                            isScanned: true,
                          ),
                        )
                      : const ListIsEmtyText(historyName: 'scanned');
                } else if (state is ErrorHiveScannedQrState) {
                  return Center(
                    child: Text('error hive: ${state.errorMessage}'),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            //! created qr codes bloc
            BlocBuilder<HiveQrCreatedBloc, HiveCreatedQrStates>(
              bloc: context.read<HiveQrCreatedBloc>()
                ..add(GetCreatedQrCodesEvent()),
              buildWhen: (previous, current) =>
                  current != previous &&
                  (current is LoadedHiveCreatedQrState ||
                      current is ErrorHiveCreatedQrState),
              builder: (context, state) {
                if (state is LoadingHiveCreatedQrState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedHiveCreatedQrState) {
                  return state.qrCodes.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.qrCodes.length,
                          itemBuilder: (context, index) {
                            return QrCodeWidget(
                              qr: state.qrCodes[index],
                              isScanned: false,
                            );
                          },
                        )
                      : const ListIsEmtyText(historyName: 'created');
                } else if (state is ErrorHiveCreatedQrState) {
                  return Center(
                    child: Text('error hive: ${state.errorMessage}'),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
