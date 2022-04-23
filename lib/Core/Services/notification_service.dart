import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:swis/Core/Services/firebase_info.dart';

class Notification_SERVICE {
  final notificationsPath =
      FirebaseFirestore.instance.collection("Notifications");

      final database = FirebaseDatabase.instance.ref('Notifications');

  Future<Response_MODEL> getNotifications(
      List<String> devices_list, first_session_date) async {



    return await notificationsPath
        .where("device_id", whereIn: devices_list)
        .where("date", isGreaterThanOrEqualTo: first_session_date)
        .get()
        .then((value) => Response_MODEL(
            message: "Notifications brought successfully!",
            success: true,
            data: value.docs.map((e) {
              e.data()["document_id"] = e.id;
              return e.data();
            }).toList()))
        .catchError((e) => Response_MODEL(
              message: "Error fetching notifications !\n reason:$e",
              success: false,
            ));
  }
}
