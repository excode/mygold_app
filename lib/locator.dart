import 'package:get_it/get_it.dart';
import 'package:mygold/apps/mygold/controller/mygold_controller.dart';
import 'package:mygold/helpers/theme/app_notifier.dart';
import 'package:mygold/realm/app_services.dart';
import 'package:mygold/realm/realm_services.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  /*
  CConfig realmConfig = CConfig.getConfig();
  // Register the services as lazy singletons
  getIt.registerLazySingleton<AppServices>(
      () => AppServices(realmConfig.appId, realmConfig.baseUrl));
  getIt.registerLazySingleton<RealmServices>(
      () => RealmServices(getIt<AppServices>().app));

  getIt.registerLazySingleton<AppNotifier>(() => AppNotifier());
  getIt.registerLazySingleton<MyGoldService>(() => MyGoldService());
  */
  CConfig realmConfig = CConfig.getConfig();

  // Register AppServices and ensure initialization
  getIt.registerSingleton<AppServices>(
    AppServices(realmConfig.appId, realmConfig.baseUrl),
  );
  final appServices = getIt<AppServices>();
  await appServices
      .initialize(); // Add an async initialization method if needed

  // Register RealmServices after AppServices is ready
  getIt.registerLazySingleton<RealmServices>(
      () => RealmServices(appServices.app));

  // Register other services
  getIt.registerLazySingleton<AppNotifier>(() => AppNotifier());
  getIt.registerLazySingleton<MyGoldService>(() => MyGoldService());
}

class CConfig {
  late String appId;
  late String atlasUrl;
  late Uri baseUrl;

  CConfig._create() {
    //appId = "mygold-user-hvvsxfy";
    appId = "mygold-zcghjzi";
    atlasUrl =
        "https://cloud.mongodb.com/links/5ff12f06cb577d031e7bedf5/explorer/excode-prod/database/collection/find";

    baseUrl = Uri.parse("https://services.cloud.mongodb.com");
  }

  static CConfig getConfig() {
    var config = CConfig._create();

    return config;
  }
}
