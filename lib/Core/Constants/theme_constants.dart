// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color MainColor = Color(0xFFD5B151);
const Color AlphaColor = Color(0xFF3C4749);
const Color BetaColor = Color(0xFF0C1013);
const Color OmgaColor = Color(0xFF2B3436);
const Color WaterColor = Color(0xFF228698);

const Color SuccessfulStateColor = Color(0xFF68B456);
const Color UnsuccessfulStateColor = Color(0xFFD55151);
const Color DanagerStateColor = Color(0xFFE5E056);

const double MainRadius = 50.0;
const double MainPadding = 20.0;

ThemeData APP_THEME = ThemeData(
  primarySwatch: Colors.blue,
);

void SANKBAR_MESSAGE(message, {seconds = 3, success = false}) {
  Get.snackbar("Ops!", '$message', onTap: (tap) {
    SANKBAR_MESSAGE(message, seconds: 5, success: success);
  },
      backgroundColor: success
          ? SuccessfulStateColor.withOpacity(0.5)
          : UnsuccessfulStateColor.withOpacity(0.5),
      padding: const EdgeInsets.all(MainPadding),
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: seconds));
}
