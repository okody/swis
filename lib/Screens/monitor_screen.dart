// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:swis/Core/Constants/theme_constants.dart';
import 'package:swis/Core/Controllers/operation_controller.dart';
import 'package:swis/Core/Utils/localstorage.dart';
import 'package:swis/Models/operation_model.dart';
import 'package:swis/Models/session_model.dart';
import 'package:swis/Screens/Widgets/empty_result.dart';
import 'package:swis/Screens/Widgets/screens_head.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Monitor_SCREEN extends StatelessWidget {
  Monitor_SCREEN({Key? key}) : super(key: key);

  LocalstorageCONTROLLER localstorageCONTROLLER =
      Get.find<LocalstorageCONTROLLER>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<OperationCOTROLLER>(
        init: Get.find<OperationCOTROLLER>(),
        builder: (operation_controller) {
          // اذا الدوكمنت ايدي تبع اول عنصر في الخزانات المتاحة فاضي اعرض لي في صفحة المراقبة الالستريشن
          return RefreshIndicator(
            onRefresh: () async {
              operation_controller.featchRefresh();
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
              child: localstorageCONTROLLER.getAvailableTanks.isEmpty
                  ? const Center(
                      child: EmptyResult(
                      message: "No operations found",
                      unDrawIllustration: UnDrawIllustration.empty,
                    ))
                  : Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: kMainPadding / 2),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 150,
                          ),
                          ScreenHead(
                              context, "Monitor".tr, Ionicons.albums_outline),
                          const SizedBox(
                            height: kMainPadding,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TankWaterLevelWidget(
                                    operation:
                                        operation_controller.lastOperation,
                                    operation_controller: operation_controller,
                                  ),
                                  const SizedBox(
                                    height: kMainPadding * 2,
                                  ),
                                  localstorageCONTROLLER
                                              .getAvailableTanks.length <=
                                          1
                                      ? const SizedBox.shrink()
                                      : GetBuilder<LocalstorageCONTROLLER>(
                                          init: Get.find<
                                              LocalstorageCONTROLLER>(),
                                          builder: (localestroage_controller) {
                                            return DropdownButtonHideUnderline(
                                              child: Container(
                                                width: 300,
                                                height: 45,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal:
                                                            kMainPadding),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            kMainRadius / 2),
                                                    border: Border.all(
                                                        color: kMainColor),
                                                    color: Colors.white
                                                        .withOpacity(0.5)),
                                                child: DropdownButton<String>(
                                                    dropdownColor: kAlphaColor,
                                                    value:
                                                        "${localstorageCONTROLLER.getAvailableTanks.first.document_id}",
                                                    icon: const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: kMainColor,
                                                      size: 25,
                                                    ),
                                                    items:
                                                        localestroage_controller
                                                            .getAvailableTanks
                                                            .map((session) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value:
                                                            "${session.document_id}",
                                                        child: Text(
                                                          "${session.name}",
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  "main_font",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15,
                                                              color:
                                                                  kMainColor),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String?
                                                            document_id) =>
                                                        operation_controller
                                                            .onTankSelected(
                                                                document_id!)),
                                              ),
                                            );
                                          }),
                                  const SizedBox(
                                    height: kMainPadding * 2,
                                  ),
                                  Container(
                                    width: size.width,
                                    height: 175,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: kMainPadding),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kMainPadding / 2),
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(
                                            kMainRadius / 2)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ReadingsProgressBar2(
                                              maxValue: 14,
                                              minGreen: false,
                                              changeColorValue: 7,
                                              readingsValue:
                                                  operation_controller
                                                      .lastOperation
                                                      .ph_readings!
                                                      .toDouble(),
                                              reaginsTitle: "PH readings".tr),
                                          ReadingsProgressBar(
                                              maxValue: 1000,
                                              displayText: "ppm",
                                              changeColorValue: 500,
                                              // readingsValue: 400,
                                              readingsValue: double.parse(
                                                  operation_controller
                                                      .lastOperation
                                                      .tds_readings
                                                      .toString()),
                                              reaginsTitle: "TDS readings".tr),
                                          ReadingsProgressBar(
                                              maxValue: 100,
                                              minGreen: false,
                                              displayText: "%",
                                              changeColorValue: 50,
                                              readingsValue:
                                                  operation_controller
                                                      .lastOperation
                                                      .water_flow_rate!
                                                      .toDouble() * 100,
                                              reaginsTitle: "Pipe flow".tr),
                                        ]),
                                  ),
                                  const SizedBox(
                                    height: kMainPadding * 2,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          );
        });
  }
}

class ReadingsProgressBar2 extends StatelessWidget {
  const ReadingsProgressBar2(
      {Key? key,
      required this.maxValue,
      required this.changeColorValue,
      required this.readingsValue,
      required this.reaginsTitle,
      this.minGreen = true,
      this.displayText = ""})
      : super(key: key);

  final double maxValue;
  final double readingsValue;
  final int changeColorValue;
  final String displayText;
  final String reaginsTitle;
  final bool minGreen;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 150,
          width: 40,
          child: FAProgressBar(
            // borderRadius: BorderRadius.circular(16),
            direction: Axis.vertical,
            verticalDirection: VerticalDirection.up,
            currentValue: readingsValue,
            displayTextStyle:
                const TextStyle(color: Colors.white, fontSize: 7.5),
            maxValue: maxValue,

            progressColor: readingsValue >= 5.6 && readingsValue < 7
                ? Colors.greenAccent
                : Colors.redAccent,
            // changeColorValue: changeColorValue,
            // changeProgressColor: minGreen ? Colors.redAccent : Colors.redAccent,
            backgroundColor: Colors.grey,
            displayText: displayText,
          ),
        ),
        const SizedBox(
          width: kMainPadding / 2,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: kMainPadding * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${readingsValue.toStringAsFixed(2)} $displayText",
                style: const TextStyle(
                    fontFamily: "main_font",
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                    color: Colors.white),
              ),
              Text(
                reaginsTitle,
                style: const TextStyle(
                    fontFamily: "main_font",
                    fontSize: 7.5,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ReadingsProgressBar extends StatelessWidget {
  const ReadingsProgressBar(
      {Key? key,
      required this.maxValue,
      required this.changeColorValue,
      required this.readingsValue,
      required this.reaginsTitle,
      this.minGreen = true,
      this.displayText = ""})
      : super(key: key);

  final double maxValue;
  final double readingsValue;
  final int changeColorValue;
  final String displayText;
  final String reaginsTitle;
  final bool minGreen;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 150,
          width: 40,
          child: FAProgressBar(
            // borderRadius: BorderRadius.circular(16),
            direction: Axis.vertical,
            verticalDirection: VerticalDirection.up,
            currentValue: readingsValue,
            displayTextStyle:
                const TextStyle(color: Colors.white, fontSize: 7.5),
            maxValue: maxValue,

            progressColor: minGreen ? Colors.greenAccent : Colors.redAccent,
            changeColorValue: changeColorValue,
            changeProgressColor: minGreen ? Colors.redAccent : Colors.redAccent,
            backgroundColor: Colors.grey,
            displayText: displayText,
          ),
        ),
        const SizedBox(
          width: kMainPadding / 2,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: kMainPadding * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${readingsValue.toStringAsFixed(2)} $displayText",
                style: const TextStyle(
                    fontFamily: "main_font",
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                    color: Colors.white),
              ),
              Text(
                reaginsTitle,
                style: const TextStyle(
                    fontFamily: "main_font",
                    fontSize: 7.5,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TankWaterLevelWidget extends StatelessWidget {
  const TankWaterLevelWidget(
      {Key? key, required this.operation, required this.operation_controller})
      : super(key: key);

  final OperationMODEL operation;
  final OperationCOTROLLER operation_controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // ClipPath(
            //   clipper:  ,
            //   child: Container(
            //     alignment: Alignment.center,
            //     width: 175,
            //     height: 175,
            //     decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         gradient: LinearGradient(
            //             begin: Alignment.topCenter,
            //             end: Alignment.bottomCenter,
            //             colors: [kWaterColor, kBetaColor])),
            //   ),
            // ),
            Container(
              alignment: Alignment.center,
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  border: Border.all(color: kAlphaColor),
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      colors: [kAlphaColor, kBetaColor])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (operation.water_tank_level! * 100).toStringAsFixed(2),
                    style: const TextStyle(
                        fontFamily: "main_font",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    "Tank Level".tr,
                    style: TextStyle(
                        fontFamily: "main_font",
                        fontSize: 12,
                        color: kMainColor.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 250,
              width: 250,
              child: SfRadialGauge(axes: <RadialAxis>[
                RadialAxis(
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: operation.water_tank_level!.toDouble() * 100,
                      cornerStyle: CornerStyle.bothCurve,
                      enableAnimation: true,
                      // animationDuration: 2000,
                      width: 0.1,
                      sizeUnit: GaugeSizeUnit.factor,
                      color: kWaterColor,
                    )
                  ],
                  minimum: 0,
                  maximum: 100,
                  showLabels: false,
                  showTicks: false,
                  axisLineStyle: const AxisLineStyle(
                    thickness: 0.1,
                    cornerStyle: CornerStyle.bothCurve,
                    color: kAlphaColor,
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),
                )
              ]),
            ),
            Positioned(
              bottom: kMainPadding / 2,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: kAlphaColor, shape: BoxShape.circle),
                    child: const Text(
                      "0%",
                      style: TextStyle(
                          fontFamily: "main_font",
                          fontSize: 11,
                          color: kWaterColor),
                    ),
                  ),
                  const SizedBox(
                    width: kMainPadding * 4.5,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: kAlphaColor, shape: BoxShape.circle),
                    child: const Text(
                      "100%",
                      style: TextStyle(
                          fontFamily: "main_font",
                          fontSize: 11,
                          color: kWaterColor),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: kMainPadding,
        ),
        Container(
          width: 225,
          // height: 25,
          padding: const EdgeInsets.symmetric(vertical: kMainPadding / 4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kMainRadius / 8),
              color: Colors.white.withOpacity(0.5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: operation_controller
                            .getOperationStateColor(operation.state!)),
                  ),
                  const SizedBox(
                    width: kMainPadding / 2,
                  ),
                  Text(
                    "${operation.state!.tr} " + "refilling".tr,
                    style: const TextStyle(
                        fontFamily: "main_font",
                        fontSize: 11,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: kMainPadding / 4,
              ),
              Text(
                "Last Refill".tr +
                    ": ${DateFormat.yMMMd().add_jm().format(operation.date!)}",
                style: const TextStyle(
                    fontFamily: "main_font", fontSize: 11, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
// DateFormat.yMMMd().format(
// class WaterCliper extends CustomClipper<Path>
// {

//   @override
//   Path getClip(Size size) {
//    var path = Path();

//    path.lineTo(0, size.height)

//    return path;
//   }
// }
