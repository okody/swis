import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swis/Core/Utils/helpers/local_notification.dart';
import 'package:swis/Screens/history_screen.dart';
import 'package:swis/Screens/monitor_screen.dart';
import 'package:swis/Screens/notification_screen.dart';
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

  void pushNotification() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message!.notification != null) {
        Get.to(() => const NotificationSCREEN());
      }
    });

    FirebaseMessaging.onMessage.listen((message) async {
      if (message.notification != null) {
        LocalNotificationService.display(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      if (message.notification != null) {
        // Get.to(() => const NotificationSCREEN());
        LocalNotificationService.display(message);
      }
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    pushNotification();
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
