import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swis/Core/Constants/theme_constants.dart';
import 'package:ionicons/ionicons.dart';
import 'package:swis/Screens/Provider/home_controller.dart';
import 'package:swis/Screens/Widgets/home_app_bar.dart';
import 'package:swis/Screens/notification_screen.dart';

class Home_SCREEN extends StatelessWidget {
  const Home_SCREEN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<Home_CONTROLLER>(
          init: Get.find<Home_CONTROLLER>(),
          builder: (home_controller) {
            return Scaffold(
              backgroundColor: kBetaColor,
              body: Stack(
                alignment: Alignment.topCenter,
                children: [
                  home_controller.CurrentScreen!,
                  MainBar(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (int index) =>
                    home_controller.onChangeBottomNavigationBarItem(index),
                selectedItemColor: kMainColor,
                currentIndex: home_controller.currentScreenIndex,
                unselectedItemColor: Colors.white,
                
                items:  [
                  BottomNavigationBarItem(
                      icon: Icon(Ionicons.server_outline), label: "History".tr),
                  BottomNavigationBarItem(
                      icon: Icon(Ionicons.albums_outline), label: "Monitor".tr),
                  BottomNavigationBarItem(
                      icon: Icon(Ionicons.server_outline), label: "Sessions".tr),
                ],
                backgroundColor: Colors.white.withOpacity(0.25),
              ),
            );
          }),
    );
  }
}
