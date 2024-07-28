import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../core/utils/const_hive.dart';
import '../../../data/models/qr.dart';

part 'hive_qr_created_events.dart';
part 'hive_qr_created_states.dart';

class HiveQrCreatedBloc extends Bloc<HiveQrCreatedEvents, HiveCreatedQrStates> {
  HiveQrCreatedBloc() : super(InitialHiveCreatedQrState()) {
    on<GetCreatedQrCodesEvent>(_getCreatedQrCodes);
    on<AddCreatedQrCodeEvent>(_addCreatedQrCode);
    on<DeleteCreatedQrCodeEvent>(_deleteCreatedQrCode);
  }

  final _historyQR = Hive.box(HiveConst.createdQR);

  void _getCreatedQrCodes(
    GetCreatedQrCodesEvent event,
    Emitter<HiveCreatedQrStates> emit,
  ) {
    emit(LoadingHiveCreatedQrState());
    try {
      final List<dynamic>? data =
          _historyQR.get(HiveConst.createdQR) as List<dynamic>?;
      emit(
        LoadedHiveCreatedQrState(
            qrCodes: data != null ? _toQrModel(data) : const []),
      );
    } catch (e) {
      emit(ErrorHiveCreatedQrState(errorMessage: e.toString()));
    }
  }

  void _addCreatedQrCode(
    AddCreatedQrCodeEvent event,
    Emitter<HiveCreatedQrStates> emit,
  ) {
    emit(LoadingHiveCreatedQrState());
    try {
      final data = _historyQR.get(HiveConst.createdQR) as List<dynamic>?;
      if (data != null) {
        data.add(Qr.toMap(event.data));
        _historyQR.put(HiveConst.createdQR, data);
      } else {
        _historyQR.put(HiveConst.createdQR, [Qr.toMap(event.data)]);
      }
      emit(
        LoadedHiveCreatedQrState(
          qrCodes: _toQrModel(_historyQR.get(HiveConst.createdQR)),
        ),
      );
    } catch (e) {
      emit(ErrorHiveCreatedQrState(errorMessage: e.toString()));
    }
  }

  void _deleteCreatedQrCode(
    DeleteCreatedQrCodeEvent event,
    Emitter<HiveCreatedQrStates> emit,
  ) async {
    emit(LoadingHiveCreatedQrState());
    try {
      final data = _historyQR.get(HiveConst.createdQR) as List<dynamic>?;
      if (data != null) {
        List<Qr> qrCodes = _toQrModel(data);

        final index = qrCodes.indexWhere((element) => element.id == event.id);
        if (index != -1) {
          qrCodes.removeAt(index);
          _historyQR.put(HiveConst.createdQR, _toMap(qrCodes));
          emit(LoadedHiveCreatedQrState(qrCodes: qrCodes));
        } else {
          emit(LoadedHiveCreatedQrState(qrCodes: qrCodes));
        }
      } else {
        emit(ErrorHiveCreatedQrState(errorMessage: 'No data found.'));
      }
    } catch (e) {
      emit(ErrorHiveCreatedQrState(errorMessage: e.toString()));
    }
  }

  List<Qr> _toQrModel(List<dynamic> data) {
    List<Qr> createdQrCodes = [];
    for (var each in data) {
      createdQrCodes.add(Qr.fromMap(each));
    }
    return createdQrCodes;
  }

  List<Map<dynamic, dynamic>> _toMap(List<Qr> data) {
    List<Map<dynamic, dynamic>> createdQrCodes = [];
    for (var each in data) {
      createdQrCodes.add(Qr.toMap(each.data, each.createdDate));
    }
    return createdQrCodes;
  }
}
