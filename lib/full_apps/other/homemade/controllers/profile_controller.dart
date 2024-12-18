import 'package:get/get.dart';
import 'package:mygold/full_apps/other/homemade/models/user.dart';

class ProfileController extends GetxController {
  bool showLoading = true, uiLoading = true;
  bool notification = true, offlineReading = false;
  late User user;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    user = await User.getOne();
    await Future.delayed(Duration(seconds: 1));

    showLoading = false;
    uiLoading = false;
    update();
  }

  void logout() {
    Get.back();
  }
}
