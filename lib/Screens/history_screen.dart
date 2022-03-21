

// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:swis/Core/Constants/theme_constants.dart';
import 'package:swis/Core/Controllers/operation_controller.dart';
import 'package:swis/Models/operation_model.dart';
import 'package:swis/Screens/Widgets/battery.dart';
import 'package:swis/Screens/Widgets/screens_head.dart';
import 'package:swis/Screens/Widgets/search_bar.dart';
import 'package:intl/intl.dart';

class History_SCREEN extends StatelessWidget {
  const History_SCREEN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Operation_CONTROLLER>(
        init: Get.find<Operation_CONTROLLER>(),
        builder: (Operation_CONTROLLER operationController) {
          return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/splash_Background.png"),
                    fit: BoxFit.cover,
                    alignment: Alignment.center),
                gradient: LinearGradient(
                    colors: [AlphaColor, BetaColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: MainPadding / 2),
              child: Column(children: [
                const SizedBox(
                  height: 150,
                ),
                ScreenHead(context, "History", Ionicons.server_outline),
                const SizedBox(
                  height: MainPadding,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: MainPadding / 2),
                  child: SerachBar(context),
                ),
                const SizedBox(
                  height: MainPadding,
                ),
                operationController.obx(
                  (operations) => Expanded(
                    child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemCount: operations!.length,
                        itemBuilder: (BuildContext context, int index) =>
                            HistoryCardItem(
                              operation: operations[index],
                              index: index,
                              operation_controller: operationController,
                            )),
                  ),
                  onLoading: const Center(child: CircularProgressIndicator()),
                  onEmpty: const Center(child: Text('No products available')),
                  onError: (error) {
                    SANKBAR_MESSAGE(error);
                    return Container();
                  },
                )
              ]),
            ),
          );
        });
  }
}

class HistoryCardItem extends StatelessWidget {
  const HistoryCardItem(
      {Key? key,
      required this.operation,
      required this.index,
      required this.operation_controller})
      : super(key: key);

  final int index;
  final Operation_MODEL operation;
  final Operation_CONTROLLER operation_controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // height: 150.0,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MainRadius / 3),
        color: Colors.white.withOpacity(0.5),
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(MainRadius / 3),
                      bottomRight: Radius.circular(MainRadius / 3))),
              child: Center(
                child: Text(
                  "#${index + 1}",
                  style: const TextStyle(
                      fontFamily: "main_font",
                      fontSize: 17.5,
                      color: Colors.white),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: MainPadding / 2),
              child: Icon(
                Ionicons.ellipsis_vertical,
                color: Colors.white,
              ),
            )
          ],
        ),
        const SizedBox(
          height: MainPadding / 2,
        ),
        Container(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: MainPadding / 2),
          height: 1.5,
        ),
        const SizedBox(
          height: MainPadding / 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MainPadding / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${operation.ph_readings}%",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontFamily: "main_font",
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        Text(
                          "PH readings",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: "main_font",
                              fontSize: 12.5,
                              color: MainColor.withOpacity(0.75)),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${operation.tds_readings}%",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontFamily: "main_font",
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        Text(
                          "TDS readings",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: "main_font",
                              fontSize: 12.5,
                              color: MainColor.withOpacity(0.75)),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${operation.water_flow_rate}%",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontFamily: "main_font",
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        Text(
                          "Pipe flow",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: "main_font",
                              fontSize: 12.5,
                              color: MainColor.withOpacity(0.75)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: MainPadding),
                child: Column(
                  children: [
                    Battery_Level(
                        percentage: operation.session.battary!, height: 30),
                    const SizedBox(
                      height: MainPadding / 8,
                    ),
                    Text(
                      "${operation.session.battary! * 100}%",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontFamily: "main_font",
                          fontSize: 12.5,
                          color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: MainPadding,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: MainPadding / 2, bottom: MainPadding / 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Tank:${operation.session.name}",
                    style: const TextStyle(
                        fontFamily: "main_font",
                        fontSize: 12,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: MainPadding,
                  ),
                  Text(
                    "Date:${DateFormat.yMd().add_jm().format(operation.date!.toDate())}",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontFamily: "main_font",
                        fontSize: 8,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              width: 100,
              height: 25,
              decoration: BoxDecoration(
                  color: operation_controller
                      .getOperationStateColor(operation.state!),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(MainRadius / 3),
                      bottomRight: Radius.circular(MainRadius / 3))),
              child: Center(
                child: Text(
                  "${operation.state}",
                  style: const TextStyle(
                      fontFamily: "main_font",
                      fontSize: 12.5,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
