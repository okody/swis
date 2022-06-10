import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swis/Core/Controllers/operation_controller.dart';
import 'package:swis/Core/Services/firebase_info.dart';
import 'package:swis/Core/Services/session_service.dart';
import 'package:swis/Core/Utils/localstorage.dart';
import 'package:swis/Models/session_model.dart';
import 'package:swis/Core/Constants/theme_constants.dart';

class SessionCONTROLLER extends GetxController
    with StateMixin<List<SessionMODEL>> {
  /// ====================================== [Instances] ======================================
  /// 1- [Vars]
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final Session_SERVICE session_service = Session_SERVICE();
  final LocalstorageCONTROLLER localstorageCONTROLLER =
      Get.find<LocalstorageCONTROLLER>();

  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  /// 2- [Funs]

  /// ====================================== [Validation] ======================================

  /// ====================================== [UIFunctions_Variables] ======================================

  List<Map<String, dynamic>> textFeidlsInfo = [
    {
      "title": "Device ID*",
      "textController": TextEditingController(),
      "value": "",
      "example": "tank001-500"
    },
    {
      "title": "Device Key*",
      "textController": TextEditingController(),
      "value": "",
      "example": "tank001-500"
    },
    {
      "title": "Session name*",
      "textController": TextEditingController(),
      "value": "",
      "example": "tank001-500"
    },
  ];

  void refreshSessionList() {
    getSessions;
  }

  /// ====================================== [CRUD] ======================================

  final List<SessionMODEL> _sessions = [];
  List<SessionMODEL> get sessions => _sessions;

  // List<OperationMODEL> getSessionss(){
  // }

  Future<void> onCreateSession(context) async {
    _loading.value = true;
    update();
    SessionMODEL session = SessionMODEL(
        name: textFeidlsInfo[2]["textController"].text,
        device_id: textFeidlsInfo[0]["textController"].text);
    session.updatePhone(await firebaseMessaging.getToken());

    ResponseMODEL isValid = await session_service.checkDevice(
        textFeidlsInfo[0]["textController"].text,
        textFeidlsInfo[1]["textController"].text);

    // if check the device with out any errors
    if (isValid.success) {
      if (isValid.data) {
        ResponseMODEL response = await session_service.createSession(session);

        if (response.success) {
          snackbar_message(response.message, success: true);

          Get.find<OperationCOTROLLER>().featchRefresh();
          Get.back();
          update();
          refreshSessionList();
        } else {
          snackbar_message(response.message);
        }
      } else {
        snackbar_message("Entred device id or access key are incorrect",
            success: false);
      }
    } else {
      snackbar_message(isValid.message);
    }
    _loading.value = false;
    update();
  }

  Future<void> onRemoveSession(SessionMODEL session) async {
    ResponseMODEL response = await session_service.removeSession(session);
    getSessions;
    Get.find<OperationCOTROLLER>().featchRefresh();
    update();

    snackbar_message(response.message);
  }

  Future<List<SessionMODEL>> get getSessions async {
    ResponseMODEL response =
        await session_service.getSesstions(await firebaseMessaging.getToken());

    if (response.success) {
      // decode data to a List of Operation Model
      var data = List<SessionMODEL>.from(response.toListModels(SessionMODEL()));
      // check if data empty or not , if not the the status is sucess and move data to widget if yes status is empty

      if (data.isNotEmpty) {
        localstorageCONTROLLER.saveAvailableTanks(data);
        change(data, status: RxStatus.success());
      } else {
        localstorageCONTROLLER.saveAvailableTanks([]);
        change(null, status: RxStatus.empty());
      }

      // snackbar_message(response.message);

      // save locally

      return data;
    } else {
      // if data has error show the letter
      change(null, status: RxStatus.error(response.message));
      return [];
    }
  }

  Future<void> updateEnableNotificatoin(String doc_id, bool isEnabled) async {
    // ResponseMODEL response =
    //     await session_service.updateNotificationEnable(doc_id, isEnabled);
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
