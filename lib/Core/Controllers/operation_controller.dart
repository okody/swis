// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swis/Core/Constants/data_constants.dart';
import 'package:swis/Core/Constants/theme_constants.dart';
import 'package:swis/Core/Controllers/session_controller.dart';
import 'package:swis/Core/Services/firebase_info.dart';
import 'package:swis/Core/Services/operation_service.dart';
import 'package:swis/Core/Utils/localstorage.dart';
import 'package:swis/Models/operation_model.dart';
import 'package:swis/Models/session_model.dart';

class OperationCOTROLLER extends GetxController
    with StateMixin<List<OperationMODEL>> {
  /// ====================================== [Instances] ======================================
  /// 1- [Vars]
  OperationSERVICE operationSERVICE = OperationSERVICE();
  // get selected defalut tank to fetch last operation on it
  LocalstorageCONTROLLER localstorageCONTROLLER =
      Get.find<LocalstorageCONTROLLER>();

  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  /// 2- [Funs]

  /// ====================================== [UI&Functions_Variables] ======================================
  /// [1] - [getDefaultTank]
  /// [2] - [onTankSelected]

  // void getDefaultTank() {
  //   defaultTank = localstorageCONTROLLER.getDefaultTank;
  //   // defaultTank = SessionMODEL(device_id: "tank001");
  // }

  Color getOperationStateColor(String state) {
    if (state == operationSuccessState) {
      return kSuccessfulStateColor;
    } else if (state == operationUnsuccessState) {
      return kUnsuccessfulStateColor;
    } else {
      return kDanagerStateColor;
    }
  }

  void onTankSelected(String docId) {
    // 2 - Save as a defualt tank
    localstorageCONTROLLER.firstify(docId);

    // // 4- get last operation based one defulat tank we've just stored
    getOperations();

    update();
  }

  /// ====================================== [CRUD] ======================================
  // final Rx<OperationMODEL> _lastOperation = OperationMODEL().obs;
  // OperationMODEL get lastOperation => _lastOperation.value;

  // List<OperationMODEL> _operations = [];
  // List<OperationMODEL> get operations => _operations;

  Future<void> getOperations() async {
    SessionCONTROLLER sessionCONTROLLER = Get.put(SessionCONTROLLER());

    List<SessionMODEL> sessions = await sessionCONTROLLER.getSessions;

    List<String> deviceIds =
        sessions.map((session) => session.device_id!).toList();

    // fetch data from server
    _loading.value = true;
    update();
    ResponseMODEL response = await operationSERVICE.getOperations(deviceIds);
    _loading.value = false;
    update();

    if (response.success) {
      // decode data to a List of Operation Model
      List<OperationMODEL> data =
          List<OperationMODEL>.from(response.toListModels(OperationMODEL()));

      data.forEach((_operation) {
        _operation.saveOperationSession(sessions);
      });

      // check if data empty or not , if not the the status is sucess and move data to widget if yes status is empty

      if (data.isNotEmpty) {
        change(data, status: RxStatus.success());
        _lastOperation = data.first;
      } else {
        change(null, status: RxStatus.empty());
      }

      // snackbar_message(response.message, success: true);
    } else {
      // if data has error show the letter
      change(null, status: RxStatus.error(response.message));
    }
  }

  OperationMODEL get lastOperation => _lastOperation;
  OperationMODEL _lastOperation = OperationMODEL().fromJson({});

  featchRefresh() {
    _lastOperation = OperationMODEL().fromJson({});

    // [2] - fetch all operatoins
    getOperations();

    update();
  }

  /// ====================================== [Override_Functions] ======================================
  @override
  void onInit() {
    // [1] - fetch last operations
    // getLastOperation();

    // [2] - fetch all operatoins
    getOperations();

    super.onInit();
  }
}
