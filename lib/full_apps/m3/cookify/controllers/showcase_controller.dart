import 'package:get/get.dart';
import 'package:mygold/full_apps/m3/cookify/models/category.dart';
import 'package:mygold/full_apps/m3/cookify/models/showcase.dart';

class ShowcaseController extends GetxController {
  bool showLoading = true, uiLoading = true;
  late List<Showcase> showcases;
  late List<Category> categories;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    showcases = await Showcase.getDummyList();
    categories = Category.getList();
    await Future.delayed(Duration(seconds: 1));
    showLoading = false;
    uiLoading = false;
    update();
  }
}
