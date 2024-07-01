import 'package:get/get.dart';
import 'package:mygold/full_apps/m3/estate/models/chat.dart';

class SingleChatController extends GetxController {
  bool showLoading = true, uiLoading = true;

  late Chat chat;

  SingleChatController(this.chat);

  @override
  void onInit() {
    super.onInit();
    // super.save = false;
    fetchData();
  }

  void fetchData() async {
    await Future.delayed(Duration(seconds: 1));

    showLoading = false;
    uiLoading = false;
    update();
  }
}
