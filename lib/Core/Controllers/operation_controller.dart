import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swis/Controllers/session_controller.dart';
import 'package:swis/Core/Constants/data_constants.dart';
import 'package:swis/Core/Constants/theme_constants.dart';
import 'package:swis/Core/Services/firebase_info.dart';
import 'package:swis/Core/Services/operation_service.dart';
import 'package:swis/Core/Utils/localstorage.dart';
import 'package:swis/Models/operation_model.dart';
import 'package:swis/Models/session_model.dart';



class Operation_CONTROLLER extends GetxController
    with StateMixin<List<Operation_MODEL>> {
  /// ====================================== [Instances] ======================================
  /// 1- [Vars]
  Operation_SERVICE operation_service = Operation_SERVICE();
  // get selected defalut tank to fetch last operation on it
  Localstorage_CONTROLLER localstorage_controller =
      Get.find<Localstorage_CONTROLLER>();

  /// 2- [Funs]

  /// ====================================== [UI&Functions_Variables] ======================================
  /// [1] - [getDefaultTank]
  /// [2] - [onTankSelected]

  Session_MODEL? defaultTank;

  void getDefaultTank() {
    defaultTank = localstorage_controller.getDefaultTank;
    // defaultTank = Session_MODEL(device_id: "tank001");
  }

  Color getOperationStateColor(String State) {
    if (State == OperationSuccessState)
      return SuccessfulStateColor;
    else if (State == OperationUnsuccessState)
      return UnsuccessfulStateColor;
    else
      return DanagerStateColor;
  }

  void onTankSelected(Session_MODEL session) {
    localstorage_controller.saveDefaultTank(session);
    getDefaultTank();
  }

  /// ====================================== [CRUD] ======================================
  // final Rx<Operation_MODEL> _lastOperation = Operation_MODEL().obs;
  // Operation_MODEL get lastOperation => _lastOperation.value;

  // List<Operation_MODEL> _operations = [];
  // List<Operation_MODEL> get operations => _operations;

  Future<void> getOperations() async {
    Session_CONTROLLER session_controller = Get.put(Session_CONTROLLER());
    List<Session_MODEL> sessions = await session_controller.getSessions;
    List<String> devices_ids =
        sessions.map((session) => session.device_id!).toList();

    // fetch data from server
    Response_MODEL response =
        await operation_service.getOperations(devices_ids);

    if (response.success) {
      // decode data to a List of Operation Model
      List<Operation_MODEL> data =
          List<Operation_MODEL>.from(response.toListModels(Operation_MODEL()));

      data.forEach((_operation) {
        _operation.saveOperationSession(sessions);
      });

      // check if data empty or not , if not the the status is sucess and move data to widget if yes status is empty
      data.isNotEmpty
          ? change(data, status: RxStatus.success())
          : change(null, status: RxStatus.empty());
      // SANKBAR_MESSAGE(response.message, success: true);
    } else {
      // if data has error show the letter
      change(null, status: RxStatus.error(response.message));
    }
  }

  Future<void> getLastOperation() async {
    // fetch data from server

    Response_MODEL response =
        await operation_service.getLastOperation(defaultTank!.device_id!);

    if (response.success) {
      // decode data to a List of Operation Model
      var data =
          List<Operation_MODEL>.from(response.toListModels(Operation_MODEL()));

      // check if data empty or not , if not the the status is sucess and move data to widget if yes status is empty
      data.isNotEmpty
          ? change(data, status: RxStatus.success())
          : change(null, status: RxStatus.empty());
      update();
      // SANKBAR_MESSAGE(response.message);
    } else {
      // if data has error show the letter
      change(null, status: RxStatus.error(response.message));
      update();
    }
  }

  /// ====================================== [Override_Functions] ======================================
  @override
  void onInit() {
    // [0] - fetch default tank
    getDefaultTank();
    // [1] - fetch last operations
    getLastOperation();

    // [2] - fetch all operatoins
    getOperations();

    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady

    super.onReady();
  }
}
