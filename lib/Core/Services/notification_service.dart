import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:swis/Core/Services/firebase_info.dart';

// creating a clase with the service name 
class NotificationSERVICE {

  // make an instance of the package and access to the database collection path
  final notificationsPath =
      FirebaseFirestore.instance.collection("Notifications");

   
  // first method to fetch the data and accepts 2 parms
  Future<ResponseMODEL> getNotifications(
      List<String> devices_list) async {


    // the query lines
    return await notificationsPath
        .where("device_id", whereIn: devices_list)
        // .where("date", isGreaterThanOrEqualTo: first_session_date)
        .get()
        .then((value) => ResponseMODEL(
            message: "Notifications brought successfully!",
            success: true,
            data: value.docs.map((e) {
              e.data()["document_id"] = e.id;
              return e.data();
            }).toList()))
        .catchError((e) => ResponseMODEL(
              message: "Error fetching notifications !\n reason:$e",
              success: false,
            ));
  }
}
