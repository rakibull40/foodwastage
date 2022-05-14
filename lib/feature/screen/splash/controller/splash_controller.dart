import 'dart:async';

import 'package:get/get.dart';
import 'package:wabmart/feature/screen/auth/first_page.dart';
import 'package:wabmart/feature/screen/home/home_screen.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    Timer(
      Duration(seconds: 3),
      nextPage,
    );
    super.onReady();
  }

  void nextPage() {
    Get.off(WelcomeScreen());
  }
}
