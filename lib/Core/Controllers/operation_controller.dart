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
  Operation_SERVICE operation_service = Operation_SERVICE();
  // get selected defalut tank to fetch last operation on it
  Localstorage_CONTROLLER localstorage_controller =
      Get.find<Localstorage_CONTROLLER>();

  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  /// 2- [Funs]

  /// ====================================== [UI&Functions_Variables] ======================================
  /// [1] - [getDefaultTank]
  /// [2] - [onTankSelected]

  SessionMODEL? defaultTank;

  void getDefaultTank() {
    defaultTank = localstorage_controller.getDefaultTank;
    // defaultTank = SessionMODEL(device_id: "tank001");
  }

  Color getOperationStateColor(String State) {
    if (State == operationSuccessState) {
      return kSuccessfulStateColor;
    } else if (State == operationUnsuccessState) {
      return kUnsuccessfulStateColor;
    } else {
      return kDanagerStateColor;
    }
  }

  void onTankSelected(SessionMODEL session) {
    localstorage_controller.saveDefaultTank(session);
    getDefaultTank();
  }

  /// ====================================== [CRUD] ======================================
  // final Rx<OperationMODEL> _lastOperation = OperationMODEL().obs;
  // OperationMODEL get lastOperation => _lastOperation.value;

  // List<OperationMODEL> _operations = [];
  // List<OperationMODEL> get operations => _operations;

  Future<void> getOperations() async {
    SessionCONTROLLER session_controller = Get.put(SessionCONTROLLER());
    List<SessionMODEL> sessions = await session_controller.getSessions;
    List<String> devices_ids =
        sessions.map((session) => session.device_id!).toList();

    // fetch data from server
    _loading.value = true;
    Response_MODEL response =
        await operation_service.getOperations(devices_ids);
    _loading.value = false;

    if (response.success) {
      // decode data to a List of Operation Model
      List<OperationMODEL> data =
          List<OperationMODEL>.from(response.toListModels(OperationMODEL()));

      data.forEach((_operation) {
        _operation.saveOperationSession(sessions);
      });

      // check if data empty or not , if not the the status is sucess and move data to widget if yes status is empty
      data.isNotEmpty
          ? change(data, status: RxStatus.success())
          : change(null, status: RxStatus.empty());
      // snackbar_message(response.message, success: true);
    } else {
      // if data has error show the letter
      change(null, status: RxStatus.error(response.message));
    }
  }

  Rx<Response_MODEL> fastResponse = Response_MODEL().obs;
  // Rx<OperationMODEL>? _lastOperation = OperationMODEL().obs;
  // OperationMODEL get lastOperation => OperationMODEL();
  // Response_MODEL get fastResponse => _fastResponse.value;

  Future<void> getLastOperation() async {
    // fastResponse.bindStream(
    //     operation_service.getLastOperation(defaultTank!.device_id!));

    // fetch data from server

    Response_MODEL response =
        await operation_service.getLastOperation(defaultTank!.device_id!);

    operation_service.getLastOperation(defaultTank!.device_id!);

    if (response.success) {
      // decode data to a List of Operation Model
      var data =
          List<OperationMODEL>.from(response.toListModels(OperationMODEL()));

      // check if data empty or not , if not the the status is sucess and move data to widget if yes status is empty
      data.isNotEmpty
          ? change(data, status: RxStatus.success())
          : change(null, status: RxStatus.empty());
      update();
      // snackbar_message(response.message);
    } else {
      // if data has error show the letter
      change(null, status: RxStatus.error(response.message));
      update();
    }
  }

  featchRefresh() {
    // [0] - fetch default tank
    getDefaultTank();
    // [1] - fetch last operations
    getLastOperation();

    // [2] - fetch all operatoins
    getOperations();

    update();
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
