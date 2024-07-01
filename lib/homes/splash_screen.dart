import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mygold/apps/auth/login1_screen.dart';
import 'package:mygold/apps/auth/otp_verification_screen.dart';
import 'package:mygold/apps/auth/reset_password1_screen.dart';
import 'package:mygold/apps/mygold/views/dashboard.dart';
import 'package:mygold/constant.dart';
import 'package:mygold/realm/app_services.dart';
import 'package:mygold/realm/realm_services.dart';
import 'package:mygold/utils/LocalStore.dart';
import 'package:mygold/utils/config.dart';
import 'package:mygold/widgets/material/appbar/app_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String authToken = '';
  String name = '';
  String username = "";
  String steps = "LOGIN";

  @override
  void initState() {
    super.initState();
    getUserId();
    Future.delayed(const Duration(seconds: 2), () {
      //  print(steps);
      // print(mobile);

      Get.offUntil(
        MaterialPageRoute(builder: (_) => pageName(steps)),
        (route) => false, // Keep the first route in the stack
      );
    });
  }

  Widget pageName(String steps) {
    switch (steps) {
      case "LOGIN":
        // print("LOGIN--");
        return const Login1Screen();
      case "LOGGED":
        return Dashboard();

      case "OTP":
        return OTPVerificationScreen();

      case "RESET":
        return ResetPasswordScreen();

      default:
        print("_DEFAULT--");
        return const Login1Screen();
    }
  }

  getUserId() async {
    LocalStore localStore = LocalStore();
    String _authToken = await localStore.read(Config.token);
    String _username = await localStore.read(Config.username);
    String _name = await localStore.read(Config.name);
    String _userId = await localStore.read(Config.userId);

    String _steps = "LOGIN";

    if (_username.isEmpty) {
      _steps = "LOGIN";
    } else if (_username.isNotEmpty && _authToken.isEmpty && _userId.isEmpty) {
      _steps = "RESET";
    } else if (_username.isNotEmpty &&
        _authToken.isEmpty &&
        _userId.isNotEmpty) {
      _steps = "OTP";
    } else if (_username.isNotEmpty &&
        _authToken.isNotEmpty &&
        _userId.isNotEmpty) {
      _steps = "LOGGED";
    }
    final RealmServices realmServices = GetIt.instance<RealmServices>();
    final appServices = GetIt.instance<AppServices>();

    await appServices.registerUserEmailPassword();
    const lang = "en";
    final result = await realmServices.searchLanguage(lang);
    realmServices.saveLangResultsToJson(result, lang);
    //setState(() {
    authToken = _authToken;
    username = _username;
    name = _name;
    steps = _steps;
    //});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("MyGold"),
      body: Center(
        child: Image.asset(
          Constant.logo,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
