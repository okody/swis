import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swis/Core/Constants/theme_constants.dart';
import 'package:swis/Screens/Provider/home_scren.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    start();

    // TODO: implement initState
    super.initState();
  }

  start() async {
    await Future.delayed(const Duration(seconds: 2), () async {
      // var user = await user_controller.getUserData();
      Get.offAll(() => Home_SCREEN());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/splash_Background.png"),
                fit: BoxFit.cover,
                alignment: Alignment.center),
            gradient: LinearGradient(
                colors: [AlphaColor, BetaColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: size.width,
                  height: MainPadding * 5,
                  decoration: const BoxDecoration(
                    color: AlphaColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(MainRadius),
                        bottomRight: Radius.circular(MainRadius)),
                  ),
                  child: Column(
                    children: const [
                      SizedBox(
                        height: MainPadding * 2,
                      ),
                      Image(
                        width: 180,
                        image: AssetImage("assets/images/tu_logo.png"),
                      ),
                    ],
                  )),
              Column(
                children: const [
                  Image(
                    image: AssetImage("assets/images/swis_logo.png"),
                  ),
                  SizedBox(
                    height: MainPadding * 2,
                  ),
                  Image(
                    image: AssetImage("assets/images/splash_icons.png"),
                  ),
                ],
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(vertical: MainPadding / 2),
                child: Opacity(
                  opacity: 0.5,
                  child: Text(
                    "CIT College Students Capstone Project 2022 ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
