part of 'hive_qr_created_bloc.dart';

@immutable
sealed class HiveQrCreatedEvents {}

class GetCreatedQrCodesEvent extends HiveQrCreatedEvents {}

class AddCreatedQrCodeEvent extends HiveQrCreatedEvents {
  final String data;

  AddCreatedQrCodeEvent({required this.data});
}

class DeleteCreatedQrCodeEvent extends HiveQrCreatedEvents {
  final int id;

  DeleteCreatedQrCodeEvent({required this.id});
}
