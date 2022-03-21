import 'package:cloud_firestore/cloud_firestore.dart';

class Session_MODEL {
  final String? document_id;
  final String? name;
  final Timestamp? date;
  final num? battary;
  final String? device_id;
  String? phone_token;

  Session_MODEL(
      {this.name,
      this.date,
      this.battary,
      this.device_id,
      this.phone_token,
      this.document_id});

  fromJson(Map<String, dynamic> data) {
    return Session_MODEL(
        document_id: data["document_id"] ?? "",
        name: data["name"] ?? "",
        date: data["date"] ?? Timestamp.now(),
        battary: data["battary"] ?? 0.0,
        device_id: data["device_id"] ?? "",
        phone_token: data["phone_token"] ?? {});
  }

  Map<String, dynamic> toStore() {
    return {
      "document_id": document_id ?? "",
      "name": name ?? "None",
      // "date": date ?? Timestamp.now(),
      "battary": battary ?? 0.0,
      "device_id": device_id ?? "None",
      "phone_token": phone_token ?? "None",
    };
  }

  /// ====================================== [Private Methods] ======================================
  void updatePhone(String? newPhone_token) {
    phone_token = newPhone_token;
  }
}
