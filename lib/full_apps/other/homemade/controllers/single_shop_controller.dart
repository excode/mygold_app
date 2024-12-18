import 'package:get/get.dart';
import 'package:mygold/full_apps/other/homemade/models/category.dart';

class SingleShopController extends GetxController {
  bool showLoading = true, uiLoading = true;
  List<Category> categories = [];

  @override
  void onInit() {
    // super.save = false;
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    categories = await Category.getDummyList();
    await Future.delayed(Duration(seconds: 1));

    showLoading = false;
    uiLoading = false;
    update();
  }
}
