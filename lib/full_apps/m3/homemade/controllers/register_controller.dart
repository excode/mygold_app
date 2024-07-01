import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygold/full_apps/m3/homemade/views/full_app.dart';
import 'package:mygold/full_apps/m3/homemade/views/login_screen.dart';

class RegisterController extends GetxController {
  late TextEditingController nameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  void register() {
    Get.off(FullApp());
    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   MaterialPageRoute(builder: (context) => FullApp()),
    // );
  }

  void goToLogin() {
    Get.off(LogInScreen());
    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //   MaterialPageRoute(builder: (context) => LogInScreen()),
    // );
  }
}
