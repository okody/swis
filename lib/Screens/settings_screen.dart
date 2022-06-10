import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ionicons/ionicons.dart';
import 'package:swis/Core/Constants/data_constants.dart';

import 'package:swis/Core/Constants/theme_constants.dart';
import 'package:swis/Core/Utils/localstorage.dart';
import 'package:swis/Screens/Widgets/private_pages_app_bar.dart';
import 'package:swis/Screens/Widgets/screens_head.dart';

class Settings_SCREEN extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBetaColor,
        body: GetBuilder<LocalstorageCONTROLLER>(
            init: Get.find<LocalstorageCONTROLLER>(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/splash_Background.png"),
                              fit: BoxFit.cover,
                              alignment: Alignment.center),
                          gradient: LinearGradient(
                              colors: [kAlphaColor, kBetaColor],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: kMainPadding / 2),
                        child: Column(children: [
                          const SizedBox(
                            height: 150,
                          ),
                          ScreenHead(
                            context,
                            "Settings",
                            Icons.settings,
                          ),
                          const SizedBox(
                            height: kMainPadding,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kMainPadding),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: kMainPadding * 2,
                                ),
                                Text(
                                  "Langauge".tr + ":",
                                  style: const TextStyle(
                                      fontFamily: "main_font",
                                      fontSize: 22.5,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  width: kMainPadding * 2,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kMainPadding * 2),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(color: kMainColor),
                                      borderRadius:
                                          BorderRadius.circular(kMainRadius)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      dropdownColor: kAlphaColor,
                                      value: controller.getLanguage,
                                      icon: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: kMainPadding / 2),
                                        child: Icon(
                                          Icons.language,
                                          color: Colors.white,
                                        ),
                                      ),
                                      items: langaugesDropdownList
                                          .map((lang) => DropdownMenuItem(
                                                value: lang,
                                                child: Text(
                                                  lang.tr,
                                                  style: const TextStyle(
                                                      fontFamily: "main_font",
                                                      fontSize: 17.5,
                                                      color: Colors.white),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (item) =>
                                          controller.changeLangague(item!),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: kMainPadding,
                          ),
                          Container(
                            width: size.width,
                            height: 1.5,
                            color: Colors.white,
                            // margin: EdgeInsets.symmetric(horizontal: kMainPadding / 2),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kMainPadding),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: kMainPadding * 2,
                                ),
                                Text(
                                  "Notification".tr + ":",
                                  style: const TextStyle(
                                      fontFamily: "main_font",
                                      fontSize: 22.5,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  width: kMainPadding * 2,
                                ),
                                Switch(
                                    value: controller.getNotification,
                                    activeColor: kMainColor,
                                    onChanged: (value) =>
                                        controller.changeNotification())
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: kMainPadding,
                          ),
                          Container(
                            width: size.width,
                            height: 1.5,
                            color: Colors.white,
                            // margin: EdgeInsets.symmetric(horizontal: kMainPadding / 2),
                          ),
                          const SizedBox(
                            height: kMainPadding,
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     controller.removeDefaultTank();
                          //   },
                          //   child: Container(
                          //     width: 250,
                          //     height: 75,
                          //     color: Colors.green,
                          //   ),
                          // ),
                          const SizedBox(
                            height: kMainPadding,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "About us".tr,
                                style: const TextStyle(
                                    fontFamily: "main_font",
                                    fontSize: 22.5,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: kMainPadding,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kMainPadding / 2),
                                child: const Text(
                                  aboutUs,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: "main_font",
                                      fontSize: 13,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(kMainPadding),
                                child: const Image(
                                  width: 180,
                                  image: const AssetImage(
                                      "assets/images/tu_logo.png"),
                                ),
                              ),
                            ],
                          )
                        ]),
                      ),
                    ),
                    const PrivateAppBar(),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
