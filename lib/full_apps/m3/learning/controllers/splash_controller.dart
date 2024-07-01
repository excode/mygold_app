import 'package:get/get.dart';
import 'package:mygold/full_apps/m3/learning/views/login_screen.dart';

class SplashController extends GetxController {
  void goToLogInScreen() {
    Get.off(LearningLogInScreen());
    // Navigator.of(context, rootNavigator: true).push(
    //   MaterialPageRoute(
    //     builder: (context) => LogInScreen(),
    //   ),
    // );
  }
}
