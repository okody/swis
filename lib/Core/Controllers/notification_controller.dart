import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:swis/Core/Controllers/session_controller.dart';
import 'package:swis/Core/Services/firebase_info.dart';
import 'package:swis/Core/Services/notification_service.dart';
import 'package:swis/Core/Utils/localstorage.dart';
import 'package:swis/Models/notification_model.dart';
import 'package:swis/Models/session_model.dart';

class NotificationCONTROLLER extends GetxController
    with StateMixin<List<Notification_MODEL>> {
  /// ====================================== [Instances] ======================================
  /// 1- [Vars]
  NotificationSERVICE notificationSERVICE = NotificationSERVICE();
  LocalstorageCONTROLLER localstorageCONTROLLER =
      Get.find<LocalstorageCONTROLLER>();

  /// 2- [Funs]

  /// ====================================== [CRUD] ======================================
  // final List<Notification_MODEL> _notifications = [];
  // List<Notification_MODEL> get notifications => _notifications;

  Future<void> getNotifications() async {
    List<SessionMODEL> sessions = localstorageCONTROLLER.getAvailableTanks;

    List<String> devices_ids =
        sessions.map((session) => session.device_id!).toList();

    ResponseMODEL response;
    if (sessions.isNotEmpty) {
      print(_getFirstSessionDate(sessions));
      response = await notificationSERVICE.getNotifications(devices_ids);
    } else {
      response = ResponseMODEL(success: true, data: []);
    }

    if (response.success) {
      // decode data to a List of Operation Model
      var data = List<Notification_MODEL>.from(
          response.toListModels(Notification_MODEL()));

      // check if data empty or not , if not the the status is sucess and move data to widget if yes status is empty
      data.isNotEmpty
          ? change(data, status: RxStatus.success())
          : change(null, status: RxStatus.empty());
      // snackbar_message(response.message);
    } else {
      // if data has error show the letter
      change(null, status: RxStatus.error(response.message));
    }
  }

  /// ====================================== [Local_Functions] ======================================

  DateTime _getFirstSessionDate(List<SessionMODEL>? sessions) {
    Timestamp time;
    List<DateTime> dates = [];
    sessions?.forEach((element) => dates.add(element.date!));

    return dates.reduce((a, b) => a.isBefore(b) ? a : b);
  }

  /// ====================================== [Override_Functions] ======================================
  @override
  void onInit() {
    // TODO: implement onInit

    getNotifications();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
}
