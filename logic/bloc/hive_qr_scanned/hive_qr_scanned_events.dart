part of 'hive_qr_scanned_bloc.dart';

@immutable
sealed class HiveQrScannedEvents {}

class GetScannedQrCodesEvent extends HiveQrScannedEvents {}

class AddScannedQrCodeEvent extends HiveQrScannedEvents {
  final String data;

  AddScannedQrCodeEvent({required this.data});
}

class DeleteScannedQrCodeEvent extends HiveQrScannedEvents {
  final int id;

  DeleteScannedQrCodeEvent({required this.id});
}
