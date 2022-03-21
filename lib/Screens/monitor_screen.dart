// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:swis/Core/Constants/theme_constants.dart';
import 'package:swis/Core/Controllers/operation_controller.dart';
import 'package:swis/Core/Utils/localstorage.dart';
import 'package:swis/Models/operation_model.dart';
import 'package:swis/Screens/Widgets/screens_head.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Monitor_SCREEN extends StatelessWidget {
  const Monitor_SCREEN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Localstorage_CONTROLLER localstorage_controller =
        Get.find<Localstorage_CONTROLLER>();

    return SingleChildScrollView(
      child: GetBuilder<Operation_CONTROLLER>(
          init: Get.find<Operation_CONTROLLER>(),
          builder: (operation_controller) {
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
                child: Column(
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    ScreenHead(context, "Monitors", Ionicons.albums_outline),
                    const SizedBox(
                      height: MainPadding,
                    ),
                    operation_controller.obx(
                      (operation) => Column(
                        children: [
                          TankWaterLevelWidget(
                            operation: operation![0],
                            operation_controller: operation_controller,
                          ),
                        ],
                      ),
                      onLoading:
                          const Center(child: CircularProgressIndicator()),
                      onEmpty:
                          const Center(child: Text('No products available')),
                      onError: (error) {
                        SANKBAR_MESSAGE(error);
                        return Container();
                      },
                    ),
                    const SizedBox(
                      height: MainPadding * 2,
                    ),
                    GetBuilder<Localstorage_CONTROLLER>(
                        init: Get.find<Localstorage_CONTROLLER>(),
                        builder: (localestroage_controller) {
                          // return GestureDetector(
                          //     onTap: () {
                          //       // localstorage_controller.saveDefaultTank(
                          //       //     Session_MODEL(
                          //       //         name: "test", device_id: "jackass"));
                          //       print(localstorage_controller.getDefaultTank);
                          //       // print(localestroage_controller.getAvailableTanks());
                          //     },
                          //     child: Container(
                          //       width: 100,
                          //       height: 100,
                          //       color: Colors.white,
                          //     ));
                          return localestroage_controller
                                  .getDefaultTank.document_id!.isEmpty
                              ? Container()
                              : DropdownButtonHideUnderline(
                                  child: Container(
                                    width: 300,
                                    height: 45,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: MainPadding),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            MainRadius / 2),
                                        border: Border.all(color: MainColor),
                                        color: Colors.white.withOpacity(0.5)),
                                    child: DropdownButton(
                                        dropdownColor: AlphaColor,
                                        value:
                                            "${localstorage_controller.getDefaultTank.document_id}",
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: MainColor,
                                          size: 25,
                                        ),
                                        items: localestroage_controller
                                            .getAvailableTanks()
                                            .map((session) {
                                          return DropdownMenuItem(
                                            value: "${session.document_id}",
                                            child: Text(
                                              "${session.name}",
                                              style: const TextStyle(
                                                  fontFamily: "main_font",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: MainColor),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (session) {
                                          localstorage_controller
                                              .saveDefaultTank(
                                                  localestroage_controller
                                                      .getAvailableTanks()
                                                      .where((oldValue) =>
                                                          session.toString() ==
                                                          (oldValue
                                                              .document_id))
                                                      .toList()[0]);
                                          Operation_CONTROLLER
                                              operation_controller =
                                              Get.find<Operation_CONTROLLER>();
                                          operation_controller
                                              .getLastOperation();
                                        }),
                                  ),
                                );
                        }),
                    const SizedBox(
                      height: MainPadding * 2,
                    ),
                    Container(
                      width: size.width,
                      height: 175,
                      margin:
                          const EdgeInsets.symmetric(horizontal: MainPadding),
                      padding: const EdgeInsets.symmetric(
                          horizontal: MainPadding / 2),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(MainRadius / 2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [0, 0, 0]
                            .map(
                              (e) => Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF7BE556),
                                          borderRadius: BorderRadius.circular(
                                              MainPadding / 4),
                                        ),
                                      ),
                                      Container(
                                        width: 35,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.6),
                                          borderRadius: BorderRadius.circular(
                                              MainPadding / 4),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: MainPadding / 2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: MainPadding * 2),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text(
                                          "3.15%",
                                          style: TextStyle(
                                              fontFamily: "main_font",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.5,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "TDS readings",
                                          style: TextStyle(
                                              fontFamily: "main_font",
                                              fontSize: 7.5,
                                              color:
                                                  MainColor.withOpacity(0.5)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: MainPadding * 2,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class TankWaterLevelWidget extends StatelessWidget {
  const TankWaterLevelWidget(
      {Key? key, required this.operation, required this.operation_controller})
      : super(key: key);

  final Operation_MODEL operation;
  final Operation_CONTROLLER operation_controller;

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
            //             colors: [WaterColor, BetaColor])),
            //   ),
            // ),
            Container(
              alignment: Alignment.center,
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  border: Border.all(color: AlphaColor),
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      colors: [AlphaColor, BetaColor])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${operation.tank_water_level! * 100}",
                    style: const TextStyle(
                        fontFamily: "main_font",
                        fontSize: 16.5,
                        color: Colors.white),
                  ),
                  Text(
                    "Tank Level",
                    style: TextStyle(
                        fontFamily: "main_font",
                        fontSize: 12,
                        color: MainColor.withOpacity(0.5)),
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
                      value: operation.tank_water_level!.toDouble() * 100,
                      cornerStyle: CornerStyle.bothCurve,
                      width: 0.1,
                      sizeUnit: GaugeSizeUnit.factor,
                      color: WaterColor,
                    )
                  ],
                  minimum: 0,
                  maximum: 100,
                  showLabels: false,
                  showTicks: false,
                  axisLineStyle: const AxisLineStyle(
                    thickness: 0.1,
                    cornerStyle: CornerStyle.bothCurve,
                    color: AlphaColor,
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),
                )
              ]),
            ),
            Positioned(
              bottom: MainPadding / 2,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: AlphaColor, shape: BoxShape.circle),
                    child: const Text(
                      "0%",
                      style: TextStyle(
                          fontFamily: "main_font",
                          fontSize: 11,
                          color: WaterColor),
                    ),
                  ),
                  const SizedBox(
                    width: MainPadding * 4.5,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: AlphaColor, shape: BoxShape.circle),
                    child: const Text(
                      "100%",
                      style: TextStyle(
                          fontFamily: "main_font",
                          fontSize: 11,
                          color: WaterColor),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: MainPadding,
        ),
        Container(
          width: 225,
          // height: 25,
          padding: const EdgeInsets.symmetric(vertical: MainPadding / 4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(MainRadius / 8),
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
                    width: MainPadding / 2,
                  ),
                  Text(
                    "${operation.state} refilling",
                    style: const TextStyle(
                        fontFamily: "main_font",
                        fontSize: 11,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: MainPadding / 4,
              ),
              Text(
                "Last Refill: ${DateFormat.yMd().add_jm().format(operation.date!.toDate())}",
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

// class WaterCliper extends CustomClipper<Path>
// {

//   @override
//   Path getClip(Size size) {
//    var path = Path();

//    path.lineTo(0, size.height)

//    return path;
//   }
// }
