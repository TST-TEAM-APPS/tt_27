import 'package:get_it/get_it.dart';
import 'package:peak_progress/repos/flagsmith.dart';
import 'package:peak_progress/repos/network_service.dart';


class Locator {
  static Future<void> setServices() async {
    GetIt.I.registerSingletonAsync<Flagsmith>(() => Flagsmith().init());
    await GetIt.I.isReady<Flagsmith>();
    GetIt.I.registerSingleton<NetworkService>(NetworkService());
  }
}
