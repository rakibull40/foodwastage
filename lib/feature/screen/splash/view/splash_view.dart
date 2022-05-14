import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wabmart/feature/screen/splash/controller/splash_controller.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
          // specify type as Controller
          init: SplashController(), // intialize with the Controller
          builder: (splashController) {
            return Scaffold(
              body: Center(
                  child: Text("Food Waste Management App")),
            );
          }),
    );
  }
}
