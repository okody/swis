// ignore_for_file: non_constant_identifier_names, camel_case_types, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:swis/Core/Constants/theme_constants.dart';
import 'package:swis/Core/Controllers/notification_controller.dart';
import 'package:swis/Models/notification_model.dart';
import 'package:swis/Screens/Widgets/empty_result.dart';
import 'package:swis/Screens/Widgets/private_pages_app_bar.dart';
import 'package:swis/Screens/Widgets/screens_head.dart';
import 'package:swis/Screens/Widgets/search_bar.dart';
import 'package:intl/intl.dart';

class NotificationSCREEN extends StatelessWidget {
  const NotificationSCREEN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GetBuilder<NotificationCONTROLLER>(
              init: Get.put(NotificationCONTROLLER()),
              builder: (notification_controller) {
                return Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/images/splash_Background.png"),
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
                          context, "Notifications", Ionicons.notifications),
                      const SizedBox(
                        height: kMainPadding,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: kMainPadding / 2),
                      //   child: SerachBar(context),
                      // ),
                      const SizedBox(
                        height: kMainPadding,
                      ),
                      notification_controller.obx(
                        (notifications) => Expanded(
                          child: ListView.separated(
                              padding:
                                  const EdgeInsets.only(bottom: kMainPadding),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                              itemCount: notifications!.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  NotificationCardItem(
                                    notification: notifications[index],
                                    index: index,
                                  )),
                        ),
                        onLoading:
                            const Center(child: CircularProgressIndicator()),
                        onEmpty: const Center(
                            child: EmptyResult(
                          message: "No notifications found",
                          unDrawIllustration: UnDrawIllustration.notify,
                        )),
                        onError: (error) {
                          snackbar_message(error);
                          return Container();
                        },
                      ),
                    ]),
                  ),
                );
              }),
          const PrivateAppBar(),
        ],
      ),
    );
  }
}

class NotificationCardItem extends StatelessWidget {
  const NotificationCardItem(
      {Key? key, required this.notification, required this.index})
      : super(key: key);

  final int index;
  final Notification_MODEL notification;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // height: 150.0,
      width: size.width,
      padding: EdgeInsets.symmetric(
          horizontal: kMainPadding / 2, vertical: kMainPadding / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kMainRadius / 3),
        color: Colors.white.withOpacity(0.5),
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Row(
        //       children: [
        //         const Icon(
        //           Icons.notifications,
        //           size: 30,
        //           color: Colors.white,
        //         ),
        //         const SizedBox(
        //           width: kMainPadding / 8,
        //         ),
        //         Text(
        //           "${notification.title}",
        //           style: const TextStyle(
        //               fontFamily: "main_font",
        //               fontSize: 15,
        //               fontWeight: FontWeight.bold,

        //               color: Colors.white),
        //         ),
        //       ],
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(
        //           left: kMainPadding / 2, bottom: kMainPadding / 4),
        //       child: Text(
        //         DateFormat.yMd()
        //             .add_jm()
        //             .format(notification.date!.toDate())
        //             .toString(),
        //         textAlign: TextAlign.left,
        //         style: const TextStyle(
        //             fontFamily: "main_font",
        //             fontSize: 12.5,
        //             color: Colors.white),
        //       ),
        //     ),
        //   ],
        // ),
        Text(
          "${notification.title}",
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: "main_font",
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        const Divider(
          color: Colors.white,
          thickness: 1.5,
        ),
        Text(
          "${notification.content} ",
          style: const TextStyle(
              fontFamily: "main_font", fontSize: 12.5, color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: kMainPadding / 2, bottom: kMainPadding / 4),
          child: Text(
            DateFormat.yMd()
                .add_jm()
                .format(notification.date!.toDate())
                .toString(),
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontFamily: "main_font", fontSize: 12.5, color: kMainColor),
          ),
        ),
      ]),
    );
  }
}
