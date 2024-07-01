import 'package:get/get.dart';
import 'package:mygold/full_apps/m3/cookify/models/user.dart';

class ProfileController extends GetxController {
  bool showLoading = true, uiLoading = true;
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
    // Navigator.pop(context);
  }
}
