import 'package:get/get.dart';
import 'package:mygold/full_apps/other/estate/models/chat.dart';

class EstateChatController extends GetxController {
  bool showLoading = true, uiLoading = true;
  List<Chat>? chats;

  @override
  void onInit() {
    // super.save = false;
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    await Future.delayed(Duration(seconds: 1));

    chats = Chat.chatList();

    showLoading = false;
    uiLoading = false;
    update();
  }
}
