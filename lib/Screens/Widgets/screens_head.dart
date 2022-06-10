import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swis/Core/Constants/theme_constants.dart';

Widget ScreenHead(context, String headline, IconData icon) {
  Size size = MediaQuery.of(context).size;
  return Container(
    child: Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              width: kMainPadding / 2,
            ),
            Text(
              headline.tr,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "main_font",
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        const SizedBox(
          height: kMainPadding / 3,
        ),
        Container(
          width: size.width,
          height: 1.5,
          color: Colors.white,
          // margin: EdgeInsets.symmetric(horizontal: kMainPadding / 2),
        )
      ],
    ),
  );
}
