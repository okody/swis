import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swis/Core/Services/firebase_info.dart';
import 'package:swis/Core/Services/session_service.dart';
import 'package:swis/Core/Utils/localstorage.dart';
import 'package:swis/Models/session_model.dart';
import 'package:swis/Core/Constants/theme_constants.dart';

class Session_CONTROLLER extends GetxController
    with StateMixin<List<Session_MODEL>> {
  /// ====================================== [Instances] ======================================
  /// 1- [Vars]
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final Session_SERVICE session_service = Session_SERVICE();
  final Localstorage_CONTROLLER localstorage_controller =
      Get.find<Localstorage_CONTROLLER>();

  /// 2- [Funs]

  /// ====================================== [Validation] ======================================

  /// ====================================== [UIFunctions_Variables] ======================================

  List<Map> TextFeidlsInfo = [
    {
      "title": "Device ID*",
      "textController": TextEditingController(),
      "example": "tank001-500"
    },
    {
      "title": "Device Key*",
      "textController": TextEditingController(),
      "example": "tank001-500"
    },
    {
      "title": "Session name*",
      "textController": TextEditingController(),
      "example": "tank001-500"
    },
  ];

  void refreshSessionList() {
    getSessions;
  }

  /// ====================================== [CRUD] ======================================
  final List<Session_MODEL> _sessions = [];
  List<Session_MODEL> get sessions => _sessions;

  // List<Operation_MODEL> getSessionss(){
  // }

  Future<void> onCreateSession(context) async {
    Session_MODEL session = Session_MODEL(
        name: TextFeidlsInfo[2]["textController"].text,
        device_id: TextFeidlsInfo[0]["textController"].text);
    session.updatePhone(await firebaseMessaging.getToken());



    Response_MODEL isValid = await session_service.checkDevice(
        TextFeidlsInfo[0]["textController"].text,
        TextFeidlsInfo[1]["textController"].text);

        


    // if check the device with out any errors
    if (isValid.success) {
      if (isValid.data) {
        Response_MODEL response = await session_service.createSession(session);
        if (response.success) {
          SANKBAR_MESSAGE(response.message, success: true);

        

          localstorage_controller.saveDefaultTank(
              response.toModel(Session_MODEL(), mainData: response.data));

          // Navigator.pop(context);
          update();
          refreshSessionList();
        } else {
          SANKBAR_MESSAGE(response.message);
        }
      } else {
        SANKBAR_MESSAGE("Entred device id or access key are incorrect",
            success: false);
      }
    } else {
      SANKBAR_MESSAGE(isValid.message);
    }
  }

  Future<void> onRemoveSession(Session_MODEL session) async {
    Response_MODEL response = await session_service.removeSession(session);
    SANKBAR_MESSAGE(response.message);
  }

  Future<List<Session_MODEL>> get getSessions async {
    Response_MODEL response =
        await session_service.getSesstions(await firebaseMessaging.getToken());

    if (response.success) {
      // decode data to a List of Operation Model
      var data =
          List<Session_MODEL>.from(response.toListModels(Session_MODEL()));
      // check if data empty or not , if not the the status is sucess and move data to widget if yes status is empty

      localstorage_controller.saveAvailableTanks(data);
      data.isNotEmpty
          ? change(data, status: RxStatus.success())
          : change(null, status: RxStatus.empty());
      // SANKBAR_MESSAGE(response.message);

      // save locally

      return data;
    } else {
      // if data has error show the letter
      change(null, status: RxStatus.error(response.message));
      return [];
    }
  }

  /// ====================================== [Override_Functions] ======================================
  @override
  void onInit() {
    // TODO: implement onInit
    getSessions;
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
}
