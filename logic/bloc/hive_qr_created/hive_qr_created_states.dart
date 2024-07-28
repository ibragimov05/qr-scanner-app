part of 'hive_qr_created_bloc.dart';

@immutable
sealed class HiveCreatedQrStates {}

final class InitialHiveCreatedQrState extends HiveCreatedQrStates {}

final class LoadingHiveCreatedQrState extends HiveCreatedQrStates {}

final class LoadedHiveCreatedQrState extends HiveCreatedQrStates {
  final List<Qr> qrCodes;

  LoadedHiveCreatedQrState({required this.qrCodes});
}

final class ErrorHiveCreatedQrState extends HiveCreatedQrStates {
  final String errorMessage;

  ErrorHiveCreatedQrState({required this.errorMessage});
}
