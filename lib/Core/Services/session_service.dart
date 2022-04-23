import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swis/Core/Services/firebase_info.dart';
import 'package:swis/Models/session_model.dart';

class Session_SERVICE {
  final sessionsPhat = FirebaseFirestore.instance.collection("Sessions");
  final devicesPhat = FirebaseFirestore.instance.collection("Devices");

  Future<Response_MODEL> checkDevice(device_id, access_key) async {
    return await devicesPhat
        .where("id", isEqualTo: device_id)
        .where("access_key", isEqualTo: access_key)
        .get()
        .then((value) =>
            Response_MODEL(success: true, data: value.docs.length != 0))
        .catchError((e) => Response_MODEL(
            success: false,
            message:
                "Something went wrong with check if device exsits \n Reason: $e"));
  }

  Future<Response_MODEL> createSession(SessionMODEL session) async {
    bool doesExists = await sessionsPhat
        .where("device_id", isEqualTo: session.device_id)
        .where("phone_token", isEqualTo: session.phone_token)
        .get()
        .then((value) => value.docs.length != 0);

    if (doesExists) {
      return Response_MODEL(
          success: false,
          message: "tf mate!! You are already connected to this device");
    } else {
      return await sessionsPhat
          .add(session.toStore())
          .then(
            (value) async => Response_MODEL(
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
          .catchError((e) => Response_MODEL(
                message: "Error creaeting the session!\n reason:$e",
                success: false,
              ));
    }
  }

  Future<Response_MODEL> removeSession(SessionMODEL session) async {
    return await sessionsPhat
        .doc(session.document_id)
        .delete()
        .then((value) => Response_MODEL(
              message: "Session deleted successfully!",
              success: true,
            ))
        .catchError((e) => Response_MODEL(
              message: "Error deleting the session! \n reason:$e",
              success: false,
            ));
  }

  Future<Response_MODEL> getSesstions(String? phone_token) async {
    return await sessionsPhat
        .where("phone_token", isEqualTo: phone_token)
        .get()
        .then((value) => Response_MODEL(
            message: "Sessions brought successfully!",
            success: true,
            data: value.docs.map((data) {
              var temp = data.data();
              temp["document_id"] = data.id;
              return temp;
            }).toList()))
        .catchError((e) => Response_MODEL(
              message: "Error fetching the session!\n reason:$e",
              success: false,
            ));
  }
}
