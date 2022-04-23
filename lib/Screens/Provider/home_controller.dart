import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swis/Screens/history_screen.dart';
import 'package:swis/Screens/monitor_screen.dart';
import 'package:swis/Screens/session_screen.dart';

class Home_CONTROLLER extends GetxController {
  /// ====================================== [UIFunctions_Variables] ======================================
  List<Widget> Screens = [History_SCREEN(), Monitor_SCREEN(), SessionSCREEN()];
  int currentScreenIndex = 0;
  Widget? CurrentScreen;

  onChangeBottomNavigationBarItem(index) {
    currentScreenIndex = index;

    CurrentScreen = Screens[index];
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    CurrentScreen = Screens[1];
    onChangeBottomNavigationBarItem(1);
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
}
