/*
* File : Main File
* We are using our own package (FlutX) : https://pub.dev/packages/flutx
* Version : 13
* */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:mygold/apps/auth/controller/member_controller.dart';
import 'package:mygold/helpers/localizations/app_localization_delegate.dart';
import 'package:mygold/helpers/localizations/language.dart';
import 'package:mygold/helpers/theme/app_notifier.dart';
import 'package:mygold/helpers/theme/app_theme.dart';
import 'package:mygold/homes/splash_screen.dart';
import 'package:mygold/locator.dart';
import 'package:mygold/realm/app_services.dart';
import 'package:mygold/realm/realm_services.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';

@RealmModel()
class LanguageFile extends RealmModel {
  @PrimaryKey()
  late String id;
  late String languageCode;
  late String jsonContent;

  LanguageFile(this.id, this.languageCode, this.jsonContent);
}

@RealmModel()
class Banner extends RealmModel {
  @PrimaryKey()
  late String id;
  late String countryCode;
  late String imageUrl;
  late String title;
  late String short;
  late String description;

  Banner(this.id, this.countryCode, this.title, this.short, this.description);
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  AppTheme.init();
  setupLocator();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppNotifier>(
          create: (context) => getIt<AppNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => MemberService(),
        ),
        // ChangeNotifierProvider<CConfig>(create: (_) => realmConfig),
        ChangeNotifierProvider<AppServices>(
            create: (_) => getIt<AppServices>()),
        ChangeNotifierProxyProvider<AppServices, RealmServices?>(
            // RealmServices can only be initialized if the user is logged in.
            create: (context) => null,
            update: (BuildContext context, AppServices appServices,
                RealmServices? realmServices) {
              return appServices.app.currentUser != null
                  ? RealmServices(appServices.app)
                  : null;
            })
        // Add other providers here if needed
      ],
      child: MyApp(),
    ),
  );

  // ChangeNotifierProvider<AppNotifier>(
  // create: (context) => AppNotifier(),

  // child: MyApp(),
  //));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
        builder: (BuildContext context, AppNotifier value, Widget? child) {
      return GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.myGoldTheme,
        home: const SplashScreen(),
        builder: (context, child) {
          return Directionality(
            textDirection: AppTheme.textDirection,
            child: child ?? Container(),
          );
        },
        localizationsDelegates: [
          AppLocalizationsDelegate(context),
          // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: Language.getLocales(),
        // home: IntroScreen(),
        // home: CookifyShowcaseScreen(),
      );
    });
  }
}
