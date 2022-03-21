import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:swis/Controllers/session_controller.dart';
import 'package:swis/Core/Constants/theme_constants.dart';
import 'package:swis/Core/Services/firebase_info.dart';
import 'package:swis/Core/Services/notification_service.dart';
import 'package:swis/Models/notification_model.dart';
import 'package:swis/Models/session_model.dart';

class Notification_CONTROLLER extends GetxController
    with StateMixin<List<Notification_MODEL>> {
  /// ====================================== [Instances] ======================================
  /// 1- [Vars]
  Notification_SERVICE notification_service = Notification_SERVICE();

  /// 2- [Funs]

  /// ====================================== [CRUD] ======================================
  // final List<Notification_MODEL> _notifications = [];
  // List<Notification_MODEL> get notifications => _notifications;

  Future<void> getNotifications() async {
    Session_CONTROLLER session_controller = Get.put(Session_CONTROLLER());
    List<Session_MODEL> sessions = await session_controller.getSessions;
    List<String> devices_ids =
        sessions.map((session) => session.device_id!).toList();

    Response_MODEL response = await notification_service.getNotifications(
        devices_ids, _getFirstSessionDate(sessions));

    if (response.success) {
      // decode data to a List of Operation Model
      var data = List<Notification_MODEL>.from(
          response.toListModels(Notification_MODEL()));

      // check if data empty or not , if not the the status is sucess and move data to widget if yes status is empty
      data.isNotEmpty
          ? change(data, status: RxStatus.success())
          : change(null, status: RxStatus.empty());
      // SANKBAR_MESSAGE(response.message);
    } else {
      // if data has error show the letter
      change(null, status: RxStatus.error(response.message));
    }
  }

  /// ====================================== [Local_Functions] ======================================

  DateTime _getFirstSessionDate(List<Session_MODEL>? sessions) {
    Timestamp time;
    List<DateTime> dates = [];
    sessions?.forEach((element) => dates.add(element.date!.toDate()));

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
