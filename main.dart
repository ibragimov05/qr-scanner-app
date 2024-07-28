import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qr_code_app/core/utils/const_hive.dart';
import 'package:qr_code_app/logic/bloc/hive_qr_created/hive_qr_created_bloc.dart';
import 'package:qr_code_app/logic/bloc/hive_qr_scanned/hive_qr_scanned_bloc.dart';
import 'package:qr_code_app/logic/bloc/observer/all_observer.dart';
import 'package:qr_code_app/logic/cubits/qr_update_cut_out_size/qr_update_cut_out_size_cubit.dart';
import 'package:qr_code_app/logic/cubits/torch/torch_cubit.dart';
import 'package:qr_code_app/logic/services/dependency_injection.dart';

import 'core/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveConst.scannedQR);
  await Hive.openBox(HiveConst.createdQR);
  DependencyInjection.setUp();

  Bloc.observer = AppBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => QrUpdateCutOutSizeCubit(),
        ),
        BlocProvider(create: (BuildContext context) => TorchCubit()),
        BlocProvider(create: (BuildContext context) => HiveQrScannedBloc()),
        BlocProvider(create: (BuildContext context) => HiveQrCreatedBloc()),
      ],
      child: const App(),
    ),
  );
}
