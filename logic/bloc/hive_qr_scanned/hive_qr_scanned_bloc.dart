import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:qr_code_app/data/models/qr.dart';

import '../../../core/utils/const_hive.dart';

part 'hive_qr_scanned_events.dart';
part 'hive_qr_scanned_states.dart';

class HiveQrScannedBloc extends Bloc<HiveQrScannedEvents, HiveScannedQrStates> {
  HiveQrScannedBloc() : super(InitialHiveScannedQrState()) {
    on<GetScannedQrCodesEvent>(_getScannedQrCodes);
    on<AddScannedQrCodeEvent>(_addScannedQrCode);
    on<DeleteScannedQrCodeEvent>(_deleteScannedQrCode);
  }

  final _historyQR = Hive.box(HiveConst.scannedQR);

  void _getScannedQrCodes(
    GetScannedQrCodesEvent event,
    Emitter<HiveScannedQrStates> emit,
  ) {
    emit(LoadingHiveScannedQrState());
    try {
      final List<dynamic>? data =
          _historyQR.get(HiveConst.scannedQR) as List<dynamic>?;
      emit(
        LoadedHiveScannedQrState(qrCodes: data != null ? _toQrModel(data) : []),
      );
    } catch (e) {
      emit(ErrorHiveScannedQrState(errorMessage: e.toString()));
    }
  }

  void _addScannedQrCode(
    AddScannedQrCodeEvent event,
    Emitter<HiveScannedQrStates> emit,
  ) {
    emit(LoadingHiveScannedQrState());
    try {
      final data = _historyQR.get(HiveConst.scannedQR) as List<dynamic>?;
      if (data != null) {
        data.add(Qr.toMap(event.data));
        _historyQR.put(HiveConst.scannedQR, data);
      } else {
        _historyQR.put(HiveConst.scannedQR, [Qr.toMap(event.data)]);
      }
      emit(
        LoadedHiveScannedQrState(
          qrCodes: _toQrModel(_historyQR.get(HiveConst.scannedQR)),
        ),
      );
    } catch (e) {
      emit(ErrorHiveScannedQrState(errorMessage: e.toString()));
    }
  }

  void _deleteScannedQrCode(
    DeleteScannedQrCodeEvent event,
    Emitter<HiveScannedQrStates> emit,
  ) async {
    emit(LoadingHiveScannedQrState());
    try {
      final data = _historyQR.get(HiveConst.scannedQR) as List<dynamic>?;
      if (data != null) {
        List<Qr> qrCodes = _toQrModel(data);

        final index = qrCodes.indexWhere((element) => element.id == event.id);
        if (index != -1) {
          qrCodes.removeAt(index);
          _historyQR.put(HiveConst.scannedQR, _toMap(qrCodes));
          emit(LoadedHiveScannedQrState(qrCodes: qrCodes));
        } else {
          emit(ErrorHiveScannedQrState(errorMessage: 'QR code not found.'));
        }
      } else {
        emit(ErrorHiveScannedQrState(errorMessage: 'No data found.'));
      }
    } catch (e) {
      emit(ErrorHiveScannedQrState(errorMessage: e.toString()));
    }
  }

  List<Qr> _toQrModel(List<dynamic> data) {
    List<Qr> scannedQrCodes = [];
    for (var each in data) {
      scannedQrCodes.add(Qr.fromMap(each));
    }
    return scannedQrCodes;
  }

  List<Map<dynamic, dynamic>> _toMap(List<Qr> data) {
    List<Map<dynamic, dynamic>> scannedQrCodes = [];
    for (var each in data) {
      scannedQrCodes.add(Qr.toMap(each.data, each.createdDate));
    }
    return scannedQrCodes;
  }
}
