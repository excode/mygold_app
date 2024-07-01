import 'package:get/get.dart';
import 'package:mygold/full_apps/m3/cookify/views/login_screen.dart';
import 'package:mygold/full_apps/m3/cookify/views/register_screen.dart';

class SplashController extends GetxController {
  void goToLogInScreen() {
    Get.to(LoginScreen());
    // Navigator.of(context, rootNavigator: true).push(
    //   MaterialPageRoute(
    //     builder: (context) => LoginScreen(),
    //   ),
    // );
  }

  void goToRegisterScreen() {
    Get.to(RegisterScreen());
    // Navigator.of(context, rootNavigator: true).push(
    //   MaterialPageRoute(
    //     builder: (context) => RegisterScreen(),
    //   ),
    // );
  }
}
