import 'package:get/get.dart';
import 'package:mygold/full_apps/other/estate/models/house.dart';

class EstateSingleEstateController extends GetxController {
  bool showLoading = true, uiLoading = true;
  late House house;

  EstateSingleEstateController(this.house);

  @override
  void onInit() {
    // super.save = false;

    getHouse();
    super.onInit();
  }

  getHouse() async {
    await Future.delayed(Duration(seconds: 1));
    showLoading = false;
    uiLoading = false;
    update();
  }
}
