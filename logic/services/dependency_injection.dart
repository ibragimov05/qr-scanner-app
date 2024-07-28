import 'package:get_it/get_it.dart';
import 'package:qr_code_app/logic/services/qr_code_services.dart';

final GetIt getIt = GetIt.instance;

class DependencyInjection {
  static void setUp(){
    getIt.registerSingleton<QrCodeServices>(QrCodeServices());
  }
}
