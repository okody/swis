import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swis/Core/Services/firebase_info.dart';
import 'package:swis/Models/operation_model.dart';
import 'package:swis/Models/session_model.dart';

class LocalstorageCONTROLLER extends GetxController {
  /// ====================================== [Instances] ======================================
  /// 1- [Vars]

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final localeStorageBox = GetStorage();

  /// 2- [Funs]

  /// ====================================== [Langauge] ======================================

  String get getLanguage => localeStorageBox.read("locale") ?? "en";

  void changeLangague(String newLangauge) async {
    final box = GetStorage();
    await localeStorageBox.write("locale", newLangauge);
    box.write("locale", newLangauge);
    update();
    Get.updateLocale(Locale(newLangauge));
  }

  /// ====================================== [notification] ======================================

  bool get getNotification => localeStorageBox.read("notificatoin") ?? false;

  Future<void> changeNotification() async {
    await localeStorageBox.write("notificatoin", !getNotification);
    getNotification
        ? firebaseMessaging.subscribeToTopic("operations")
        : firebaseMessaging.unsubscribeFromTopic("operations");
    update();
  }

  /// ====================================== [Session] ======================================
  // Future<void> saveDefaultTank(SessionMODEL session) async {
  //   await localeStorageBox.write("DefaultTank", json.encode(session.toStore()));
  //   update();
  // }

  // void removeDefaultTank() {
  //   localeStorageBox.remove("DefaultTank");
  // }

  // SessionMODEL get getDefaultTank {
  //   String defaultTank = localeStorageBox.read("DefaultTank") ?? "";

  //   return ResponseMODEL().toModel(SessionMODEL(),
  //       mainData: defaultTank.isNotEmpty
  //           ? json.decode(defaultTank)
  //           : SessionMODEL().toStore());
  // }

  void firstify(String doc_id) {

    List<SessionMODEL> temp = getAvailableTanks;
    localeStorageBox.remove("AvailableTanks");
    print(temp.first.device_id);
        SessionMODEL firstSession =
        temp.where((element) => element.document_id == doc_id).toList().first;
    temp.removeWhere((element) => element.document_id == doc_id);
    temp.insert(0, firstSession);
   
    saveAvailableTanks(temp);

    print(getAvailableTanks.first.device_id);

    

  }

  Future<void> saveAvailableTanks(List<SessionMODEL> sessions) async {
  
    await localeStorageBox.write("AvailableTanks",
        json.encode(sessions.map((session) => session.toStore()).toList()));
  }

  List<SessionMODEL> get getAvailableTanks {
    final tanks = json.decode(localeStorageBox.read("AvailableTanks")!);

    return List<SessionMODEL>.from(ResponseMODEL().toListModels(SessionMODEL(),
        mainData: tanks ?? []));
  }

  /// ====================================== [Operation] ======================================

  // Future<OperationMODEL> saveLastOperation(OperationMODEL operation) async {
  //   await localeStorageBox.write("lastOperation", json.encode(operation.toStore()));
  //   return operation;
  // }

  // OperationMODEL getLastOperation() {
  //   return OperationMODEL().fromJson(
  //       json.decode(localeStorageBox.read("lastOperation")!) ??
  //           OperationMODEL().toStore());
  // }

  /// ========================================================================================
  /// ====================================== [Override] ======================================

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
