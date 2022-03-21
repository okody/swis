import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swis/Core/Constants/theme_constants.dart';
import 'package:swis/Screens/notification_screen.dart';
import 'package:swis/Screens/settings_screen.dart';

class MainBar extends StatelessWidget {
  const MainBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
          horizontal: MainPadding, vertical: MainPadding),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(MainRadius),
              bottomRight: Radius.circular(MainRadius))),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage("assets/images/swis_logo.png"),
              width: 60,
            ),
            Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: OmgaColor,
                      borderRadius: BorderRadius.circular(MainRadius / 8)),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => Notification_SCREEN());
                    },
                    child: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  width: MainPadding / 2,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => Settings_SCREEN());
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        color: OmgaColor,
                        borderRadius: BorderRadius.circular(MainRadius / 8)),
                    child: const Icon(
                      Icons.settings,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ]),
    );
  }
}
