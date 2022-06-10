import 'package:cloud_firestore/cloud_firestore.dart';

class SessionMODEL {
  final String? document_id;
  final String? name;
  final DateTime? date;
  final num? battary;
  final String? device_id;
  final bool? notificationEnable;
  String? phone_token;

  SessionMODEL(
      {this.name,
      this.date,
      this.notificationEnable,
      this.battary,
      this.device_id,
      this.phone_token,
      this.document_id});

  fromJson(Map<String, dynamic> data) {
    return SessionMODEL(
        document_id: data["document_id"] ?? "",
        name: data["name"] ?? "",
        notificationEnable: data["notificationEnable"] ?? true,
        date: data["date"] != null
            ? DateTime.parse(data["date"].toDate().toString())
            : DateTime.now(),
        battary: data["battary"] ?? 0.0,
        device_id: data["device_id"] ?? "",
        phone_token: data["phone_token"] ?? {});
  }

  Map<String, dynamic> toStore() {
    return {
      "document_id": document_id ?? "",
      "name": name ?? "None",
      // "date": date ?? DateTime.now().toIso8601String(),
      "battary": battary ?? 0.0,
      "device_id": device_id ?? "None",
      "phone_token": phone_token ?? "None",
      "notificationEnable": true
    };
  }

  /// ====================================== [Private Methods] ======================================
  void updatePhone(String? newPhone_token) {
    phone_token = newPhone_token;
  }
}
