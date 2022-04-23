import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:swis/Core/Constants/theme_constants.dart';
import 'package:swis/Core/Controllers/session_controller.dart';
import 'package:swis/Core/Utils/helpers/strings.dart';
import 'package:swis/Models/session_model.dart';
import 'package:swis/Screens/Widgets/battery.dart';
import 'package:swis/Screens/Widgets/screens_head.dart';
import 'package:swis/Screens/Widgets/search_bar.dart';

class SessionSCREEN extends StatelessWidget {
  const SessionSCREEN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<SessionCONTROLLER>(
        init: Get.find<SessionCONTROLLER>(),
        builder: (session_controller) {
          return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/splash_Background.png"),
                    fit: BoxFit.cover,
                    alignment: Alignment.center),
                gradient: LinearGradient(
                    colors: [kAlphaColor, kBetaColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: kMainPadding / 2),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Column(children: [
                    const SizedBox(
                      height: 150,
                    ),
                    ScreenHead(
                        context, "Sessions", Ionicons.hardware_chip_outline),
                    const SizedBox(
                      height: kMainPadding,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kMainPadding / 2),
                      child: SerachBar(context),
                    ),
                    const SizedBox(
                      height: kMainPadding,
                    ),
                    session_controller.obx(
                      (sessions) => Expanded(
                        child: ListView.separated(
                            padding: EdgeInsets.only(bottom: kMainPadding),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemCount: sessions!.length,
                            itemBuilder: (BuildContext context, int index) =>
                                SessionCardItem(
                                  session: sessions[index],
                                  index: index,
                                )),
                      ),
                      onLoading: const Center(child: CircularProgressIndicator()),
                      onEmpty: const Center(child: Text('No products available')),
                      onError: (error) {
                        snackbar_message(error);
                        return Container();
                      },
                    ),
                  ]),
                  GestureDetector(
                    onTap: () {
                      AddSessionWidget(context, size, session_controller);
                    },
                    child: Container(
                      width: 55,
                      height: 55,
                      margin: const EdgeInsets.all(kMainPadding),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<dynamic> AddSessionWidget(
      BuildContext context, Size size, SessionCONTROLLER session_controller) {
    return showDialog(
        context: context,
        barrierColor: Colors.white.withOpacity(0.5),
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Center(
                child: Container(
                  width: size.width,
                  height: size.height * 0.5,
                  margin: EdgeInsets.all(kMainPadding),
                  decoration: BoxDecoration(
                      color: kMainColor.withOpacity(0.3),
                      border: Border.all(color: kMainColor),
                      borderRadius: BorderRadius.circular(kMainRadius)),
                  child:
                      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment:
                          //     CrossAxisAlignment.start,
                          children: [
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: kMainPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kMainPadding * 2),
                                child: Text(
                                  "Add session",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: "main_font",
                                      fontSize: 25,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 1.5,
                                width: size.width,
                                color: Colors.white,
                                margin: EdgeInsets.symmetric(
                                    horizontal: kMainPadding / 2),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: session_controller.TextFeidlsInfo.map(
                              (fieldInfo) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "   ${fieldInfo["title"]}",
                                    style: TextStyle(
                                        fontFamily: "main_font",
                                        fontSize: 15,
                                        color: Colors.white),
                                  ),
                                  Container(
                                    height: 45,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: kMainPadding / 2),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: kMainColor),
                                        borderRadius: BorderRadius.circular(
                                            kMainRadius / 4)),
                                    child: Card(
                                      elevation: 0.0,
                                      child: TextField(
                                        controller: fieldInfo["textController"],
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 20,
                                            fontFamily: "main_font"),
                                        textAlign: TextAlign.left,
                                        cursorColor: kMainColor,
                                        decoration: InputDecoration(
                                            alignLabelWithHint: true,
                                            hintText:
                                                "example: ${fieldInfo["example"]}",
                                            hintStyle: TextStyle(
                                                fontSize: 15,
                                                fontFamily: "main_font",
                                                color: Colors.grey
                                                    .withOpacity(0.1)),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ).toList(),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () =>
                                session_controller.onCreateSession(context),
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: kMainColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(kMainRadius),
                                      bottomRight:
                                          Radius.circular(kMainRadius))),
                              child: Icon(
                                Icons.add,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ]),
                ),
              ),
            ),
          );
        });
  }
}

class SessionCardItem extends StatelessWidget {
  const SessionCardItem({Key? key, required this.session, required this.index})
      : super(key: key);

  final int index;
  final SessionMODEL session;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // height: 150.0,
      width: size.width,
      decoration: BoxDecoration(
        border: Border.all(color: kMainColor),
        borderRadius: BorderRadius.circular(kMainRadius / 3),
        color: Colors.white.withOpacity(0.5),
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        // [Main Card Column: Number + Option Raw]
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kMainRadius / 3),
                      bottomRight: Radius.circular(kMainRadius / 3))),
              child: Center(
                child: Text(
                  "#${index + 1}",
                  style: TextStyle(
                      fontFamily: "main_font",
                      fontSize: 17.5,
                      color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: kMainPadding / 2),
              child: Icon(
                Ionicons.ellipsis_vertical,
                color: Colors.white,
              ),
            )
          ],
        ),
        SizedBox(
          height: kMainPadding,
        ),

        // [Main Card Column: Battary and Data Row]
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kMainPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // [Main Card Column: Data and Battary: Data Column]
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //[Main Card Column: Data and Battary: Data Column : First Data TankID]
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.copy,
                            color: kMainColor,
                          ),
                          SizedBox(
                            width: kMainPadding / 4,
                          ),
                          Text(
                            "#${session.device_id}",
                            style: TextStyle(
                                fontFamily: "main_font",
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Text(
                        "  Tank ID",
                        style: TextStyle(
                            fontFamily: "main_font",
                            fontSize: 12.5,
                            color: kMainColor.withOpacity(0.5)),
                      ),
                    ],
                  ),
                  //[Main Card Column: Data and Battary: Data Column : Second Data Phone Token]
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.copy,
                            color: kMainColor,
                          ),
                          SizedBox(
                            width: kMainPadding / 4,
                          ),
                          Text(
                            "#${getSubString(session.phone_token!, 20)}",
                            style: TextStyle(
                                fontFamily: "main_font",
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Text(
                        "  Phone token",
                        style: TextStyle(
                            fontFamily: "main_font",
                            fontSize: 12.5,
                            color: kMainColor.withOpacity(0.5)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: kMainPadding / 4,
                  ),

                  //[Main Card Column: Data and Battary: Data Column : 3rd Data dates row]
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //[Main Card Column: Data and Battary: Data Column : 3rd Data dates row // pairing date]
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "100%",
                            style: TextStyle(
                                fontFamily: "main_font",
                                fontSize: 15,
                                color: Colors.white.withOpacity(0.5)),
                          ),
                          Text(
                            "100%",
                            style: TextStyle(
                                fontFamily: "main_font",
                                fontSize: 15,
                                color: kMainColor.withOpacity(0.5)),
                          ),
                        ],
                      ),

                      //[Main Card Column: Data and Battary: Data Column : 3rd Data dates row : last operation date]
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "100%",
                            style: TextStyle(
                                fontFamily: "main_font",
                                fontSize: 15,
                                color: Colors.white.withOpacity(0.5)),
                          ),
                          Text(
                            "100%",
                            style: TextStyle(
                                fontFamily: "main_font",
                                fontSize: 15,
                                color: kMainColor.withOpacity(0.5)),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              //[Main Card Column: Data and Battary: Batary
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Battery_Level(
                    percentage: session.battary!,
                    height: 88,
                  ),
                  Text(
                    "${session.battary! * 100}%",
                    style: TextStyle(
                        fontFamily: "main_font",
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
