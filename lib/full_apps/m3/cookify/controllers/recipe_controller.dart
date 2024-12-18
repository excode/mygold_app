import 'package:get/get.dart';
import 'package:mygold/full_apps/m3/cookify/models/full_recipe.dart';

class RecipeController extends GetxController {
  bool showLoading = true, uiLoading = true;
  late FullRecipe recipe;
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    recipe = await FullRecipe.getSingle();
    await Future.delayed(Duration(seconds: 1));
    showLoading = false;
    uiLoading = false;
    update();
  }
}
