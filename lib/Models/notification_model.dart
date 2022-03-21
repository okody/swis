import 'package:cloud_firestore/cloud_firestore.dart';

class Notification_MODEL {
  final String? document_id;
  final String? title;
  final Timestamp? date;
  final String? content;
  final String? device_id;
  final String? operation_id;

  Notification_MODEL(
      {this.document_id,
      this.title,
      this.date,
      this.content,
      this.device_id,
      this.operation_id});

  fromJson(Map<String, dynamic> data) {
    return Notification_MODEL(
        document_id: data["id"] ?? "",
        title: data["title"] ?? "",
        date: data["date"] ?? Timestamp.now(),
        content: data["content"] ?? "",
        device_id: data["device_id"] ?? "",
        operation_id: data["operation_id"] ?? "");
  }

  Map<String, dynamic> toStore() {
    return {
      "title": title ?? "",
      "date": date ?? Timestamp.now(),
      "content": content ?? "",
      "device_id": device_id ?? "",
      "operation_id": operation_id ?? ""
    };
  }
}
