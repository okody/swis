import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swis/Core/Services/firebase_info.dart';
import 'package:swis/Models/session_model.dart';

class Session_SERVICE {
  final sessionsPhat = FirebaseFirestore.instance.collection("Sessions");
  final devicesPhat = FirebaseFirestore.instance.collection("Devices");

  Future<ResponseMODEL> checkDevice(device_id, access_key) async {
    print("access key: =================> ${access_key}");
    return await devicesPhat
        .where("id", isEqualTo: device_id)
        .where("access_key", isEqualTo: access_key)
        .get()
        .then((value) =>
            ResponseMODEL(success: true, data: value.docs.length != 0))
        .catchError((e) => ResponseMODEL(
            success: false,
            message:
                "Something went wrong with check if device exsits \n Reason: $e"));
  }

  Future<ResponseMODEL> createSession(SessionMODEL session) async {
    bool doesExists = await sessionsPhat
        .where("device_id", isEqualTo: session.device_id)
        .where("phone_token", isEqualTo: session.phone_token)
        .get()
        .then((value) => value.docs.length != 0);

    if (doesExists) {
      return ResponseMODEL(
          success: false, message: "You've already connected to this device");
    } else {
      return await sessionsPhat
          .add(session.toStore())
          .then(
            (value) async => ResponseMODEL(
              message: "Session created successfully!",
              success: true,
              data: await value.get().then(
                (data) {
                  var temp = data.data()!;
                  temp["document_id"] = data.id;
                  return temp;
                },
              ),
            ),
          )
          .catchError((e) => ResponseMODEL(
                message: "Error creaeting the session!\n reason:$e",
                success: false,
              ));
    }
  }

  Future<ResponseMODEL> removeSession(SessionMODEL session) async {
    return await sessionsPhat
        .doc(session.document_id)
        .delete()
        .then((value) => ResponseMODEL(
              message: "Session deleted successfully!",
              success: true,
            ))
        .catchError((e) => ResponseMODEL(
              message: "Error deleting the session! \n reason:$e",
              success: false,
            ));
  }

  Future<ResponseMODEL> getSesstions(String? phone_token) async {
    return await sessionsPhat
        .where("phone_token", isEqualTo: phone_token)
        .get()
        .then((value) => ResponseMODEL(
            message: "Sessions brought successfully!",
            success: true,
            data: value.docs.map((data) {
              var temp = data.data();
              temp["document_id"] = data.id;
              return temp;
            }).toList()))
        .catchError((e) => ResponseMODEL(
              message: "Error fetching the session!\n reason:$e",
              success: false,
            ));
  }

  // Future<void> updateNotificationEnable(
  //     String phone_token, bool isEnabled) async {
  //  await sessionsPhat
  //       .where('answer', isEqualTo : 'value')
  // ..then((value) => value.docs.forEach((doc) {
  //     doc.reference.update({'answer': ''});
  //   }
  //   ));
    
  // }
}
