// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:swis/Core/Constants/theme_constants.dart';
import 'package:swis/Core/Controllers/operation_controller.dart';
import 'package:swis/Models/operation_model.dart';
import 'package:swis/Screens/Widgets/battery.dart';
import 'package:swis/Screens/Widgets/empty_result.dart';
import 'package:swis/Screens/Widgets/screens_head.dart';
import 'package:swis/Screens/Widgets/search_bar.dart';
import 'package:intl/intl.dart';

class History_SCREEN extends StatelessWidget {
  const History_SCREEN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OperationCOTROLLER>(
        init: Get.find<OperationCOTROLLER>(),
        builder: (OperationCOTROLLER operationController) {
          return RefreshIndicator(
            onRefresh: () async {
              operationController.featchRefresh();
              // return true;
            },
            child: Container(
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
                margin:
                    const EdgeInsets.symmetric(horizontal: kMainPadding / 2),
                child: Column(children: [
                  const SizedBox(
                    height: 150,
                  ),
                  ScreenHead(context, "History", Ionicons.server_outline),
                  const SizedBox(
                    height: kMainPadding,
                  ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: kMainPadding / 2),
                  //   child: SerachBar<OperationMODEL>(context,
                  //       items: [],
                  //       filter: (OperationMODEL operation) =>
                  //           [operation.device_id , operation.tds_readings],
                  //       builder: (OperationMODEL operation) => HistoryCardItem(
                  //           operation: operation,
                  //           index: 0,
                  //           operation_controller: operationController)),
                  // ),
                  // const SizedBox(
                  //   height: kMainPadding,
                  // ),
                  Expanded(
                    child: operationController.obx(
                      (operations) => ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                          itemCount: operations!.length,
                          itemBuilder: (BuildContext context, int index) =>
                              HistoryCardItem(
                                operation: operations[index],
                                index: index,
                                operation_controller: operationController,
                              )),
                      onLoading:
                          const Center(child: CircularProgressIndicator()),
                      onEmpty: const Center(
                          child: EmptyResult(
                        message: "No operations found",
                        unDrawIllustration: UnDrawIllustration.empty,
                      )),
                      onError: (error) {
                        // snackbar_message(error.toString());
                        print(error.toString());
                        return Container();
                      },
                    ),
                  )
                ]),
              ),
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
  final OperationMODEL operation;
  final OperationCOTROLLER operation_controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // height: 150.0,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kMainRadius / 3),
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
                      topLeft: Radius.circular(kMainRadius / 3),
                      bottomRight: Radius.circular(kMainRadius / 3))),
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
            SizedBox()
          ],
        ),
        const SizedBox(
          height: kMainPadding / 2,
        ),
        Container(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: kMainPadding / 2),
          height: 1.5,
        ),
        const SizedBox(
          height: kMainPadding / 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kMainPadding / 2),
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
                          operation.ph_readings!.toStringAsFixed(2),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontFamily: "main_font",
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        Text(
                          "PH readings".tr,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontFamily: "main_font",
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${operation.tds_readings!.toStringAsFixed(2)} ppm",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontFamily: "main_font",
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        Text(
                          "TDS readings".tr,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontFamily: "main_font",
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                                style: const TextStyle(
                                    fontFamily: "main_font",
                                    fontSize: 20,
                                    color: Colors.white),
                                children: [
                                  TextSpan(
                                      text:
                                          "${operation.water_flow_value!.toStringAsFixed(2)} "),
                                  const TextSpan(
                                      text: "L/min",
                                      style: TextStyle(fontSize: 15))
                                ])),
                        Text(
                          "Pipe flow".tr,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontFamily: "main_font",
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: kMainPadding),
                child: Column(
                  children: [
                    Battery_Level(
                        percentage: operation.session.battary ?? 0.0,
                        height: 30),
                    const SizedBox(
                      height: kMainPadding / 8,
                    ),
                    Text(
                      "${((operation.session.battary ?? 0) * 100).toStringAsFixed(2)}%",
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
          height: kMainPadding,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: kMainPadding / 2, bottom: kMainPadding / 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Tank".tr + ":${operation.session.name}",
                    style: const TextStyle(
                        fontFamily: "main_font",
                        fontSize: 12,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: kMainPadding,
                  ),
                  Text(
                    "Date".tr +
                        ":${DateFormat.yMd().add_jm().format(operation.date!)}",
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
                      topLeft: Radius.circular(kMainRadius / 3),
                      bottomRight: Radius.circular(kMainRadius / 3))),
              child: Center(
                child: Text(
                  "${operation.state}".tr,
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
