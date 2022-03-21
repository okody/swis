import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swis/Core/Constants/theme_constants.dart';
import 'package:swis/Screens/notification_screen.dart';

class PrivateAppBar extends StatelessWidget {
  const PrivateAppBar({
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
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                size: 40,
                color: Colors.white,
              ),
            ),
            const Image(
              image: AssetImage("assets/images/swis_logo.png"),
              width: 60,
            ),
          ]),
    );
  }
}
