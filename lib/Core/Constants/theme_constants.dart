// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color kMainColor = Color(0xFFD5B151);
const Color kAlphaColor = Color(0xFF3C4749);
const Color kBetaColor = Color(0xFF0C1013);
const Color kOmgaColor = Color(0xFF2B3436);
const Color kWaterColor = Color(0xFF228698);

const Color kSuccessfulStateColor = Color(0xFF68B456);
const Color kUnsuccessfulStateColor = Color(0xFFD55151);
const Color kDanagerStateColor = Color(0xFFE5E056);

const double kMainRadius = 50.0;
const double kMainPadding = 20.0;

ThemeData kAPP_THEME = ThemeData(
  primarySwatch: Colors.blue,
);

void snackbar_message(message, {seconds = 3, success = false}) {
  Get.snackbar("Ops!", '$message', onTap: (tap) {
    // snackbar_message(message, seconds: 5, success: success);
  },
      backgroundColor: success
          ? kSuccessfulStateColor.withOpacity(0.5)
          : kUnsuccessfulStateColor.withOpacity(0.5),
      padding: const EdgeInsets.all(kMainPadding),
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: seconds));
}
