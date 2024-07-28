part of 'hive_qr_scanned_bloc.dart';

@immutable
sealed class HiveScannedQrStates {}

final class InitialHiveScannedQrState extends HiveScannedQrStates {}

final class LoadingHiveScannedQrState extends HiveScannedQrStates {}

final class LoadedHiveScannedQrState extends HiveScannedQrStates {
  final List<Qr> qrCodes;

  LoadedHiveScannedQrState({required this.qrCodes});
}

final class ErrorHiveScannedQrState extends HiveScannedQrStates {
  final String errorMessage;

  ErrorHiveScannedQrState({required this.errorMessage});
}
