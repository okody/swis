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
        backgroundColor: BetaColor,
        body: GetBuilder<Localstorage_CONTROLLER>(
            init: Get.find<Localstorage_CONTROLLER>(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/splash_Background.png"),
                              fit: BoxFit.cover,
                              alignment: Alignment.center),
                          gradient: LinearGradient(
                              colors: [AlphaColor, BetaColor],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: MainPadding / 2),
                        child: Column(children: [
                          SizedBox(
                            height: 150,
                          ),
                          ScreenHead(
                            context,
                            "Settings",
                            Icons.settings,
                          ),
                          SizedBox(
                            height: MainPadding,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: MainPadding),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MainPadding * 2,
                                ),
                                Text(
                                  "Langague:",
                                  style: TextStyle(
                                      fontFamily: "main_font",
                                      fontSize: 22.5,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: MainPadding * 2,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: MainPadding * 2),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(color: MainColor),
                                      borderRadius:
                                          BorderRadius.circular(MainRadius)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      dropdownColor: AlphaColor,
                                      value: controller.getLanguage,
                                      icon: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: MainPadding / 2),
                                        child: Icon(
                                          Icons.language,
                                          color: Colors.white,
                                        ),
                                      ),
                                      items: LangaugesDropdownList.map(
                                          (lang) => DropdownMenuItem(
                                                value: lang,
                                                child: Text(
                                                  lang.tr,
                                                  style: TextStyle(
                                                      fontFamily: "main_font",
                                                      fontSize: 17.5,
                                                      color: Colors.white),
                                                ),
                                              )).toList(),
                                      onChanged: (item) =>
                                          controller.changeLangague(item!),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MainPadding,
                          ),
                          Container(
                            width: size.width,
                            height: 1.5,
                            color: Colors.white,
                            // margin: EdgeInsets.symmetric(horizontal: MainPadding / 2),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: MainPadding),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MainPadding * 2,
                                ),
                                Text(
                                  "Notification:",
                                  style: TextStyle(
                                      fontFamily: "main_font",
                                      fontSize: 22.5,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: MainPadding * 2,
                                ),
                                Switch(
                                    value: controller.getNotification,
                                    activeColor: MainColor,
                                    onChanged: (value) =>
                                        controller.changeNotification())
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MainPadding,
                          ),
                          Container(
                            width: size.width,
                            height: 1.5,
                            color: Colors.white,
                            // margin: EdgeInsets.symmetric(horizontal: MainPadding / 2),
                          ),
                          SizedBox(
                            height: MainPadding,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "About Us",
                                style: TextStyle(
                                    fontFamily: "main_font",
                                    fontSize: 22.5,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: MainPadding,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: MainPadding / 2),
                                child: Text(
                                  AboutUs,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "main_font",
                                      fontSize: 13,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(MainPadding),
                                child: Image(
                                  width: 180,
                                  image: AssetImage("assets/images/tu_logo.png"),
                                ),
                              ),
                            ],
                          )
                        ]),
                      ),
                    ),
                    PrivateAppBar(),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
