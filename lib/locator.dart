import 'package:get_it/get_it.dart';
import 'package:mygold/helpers/theme/app_notifier.dart';
import 'package:mygold/realm/app_services.dart';
import 'package:mygold/realm/realm_services.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  CConfig realmConfig = CConfig.getConfig();
  // Register the services as lazy singletons
  getIt.registerLazySingleton<AppServices>(
      () => AppServices(realmConfig.appId, realmConfig.baseUrl));
  getIt.registerLazySingleton<RealmServices>(
      () => RealmServices(getIt<AppServices>().app));

  getIt.registerLazySingleton<AppNotifier>(() => AppNotifier());
}

class CConfig {
  late String appId;
  late String atlasUrl;
  late Uri baseUrl;

  CConfig._create() {
    appId = "excode-sync-hhtmcal";
    atlasUrl =
        "https://cloud.mongodb.com/links/5ff12f06cb577d031e7bedf5/explorer/excode-prod/database/collection/find";
    baseUrl = Uri.parse("https://services.cloud.mongodb.com");
  }

  static CConfig getConfig() {
    var config = CConfig._create();

    return config;
  }
}