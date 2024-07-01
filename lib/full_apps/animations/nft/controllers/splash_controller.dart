import 'package:get/get.dart';
import 'package:mygold/full_apps/animations/nft/views/login_screen.dart';
import 'package:mygold/full_apps/animations/nft/views/register_screen.dart';

class SplashController extends GetxController {
  void goToLoginScreen() {
    Get.off(LoginScreen());
    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => LoginScreen(),
    //   ),
    // );
  }

  void goToRegisterScreen() {
    Get.off(RegisterScreen());
    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => RegisterScreen(),
    //   ),
    // );
  }
}