import 'package:get/get.dart';
import 'package:mygold/full_apps/m3/dating/views/home_screen.dart';

class SplashController extends GetxController {
  void goToHomeScreen() {
    Get.to(HomeScreen());
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
