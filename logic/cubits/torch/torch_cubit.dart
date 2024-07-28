import 'package:bloc/bloc.dart';

class TorchCubit extends Cubit<bool> {
  TorchCubit() : super(false);

  void toggleTorch() => emit(!state);
}
