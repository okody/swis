// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swis/Core/Services/firebase_info.dart';

class Operation_SERVICE {
  final operationsPath = FirebaseFirestore.instance.collection("Operatoins");
  // final devicesPhat = FirebaseFirestore.instance.collection("Devices");

  Future<Response_MODEL> getOperations(List<String> devices_list) async {
    return await operationsPath
        .where("device_id", whereIn: devices_list)
        .get()
        .then((value) => Response_MODEL(
            message: "Operations brought successfully!",
            success: true,
            data: value.docs.map((e) {
              Map document = e.data();
              document["document_id"] = e.id;
              return document;
            }).toList()))
        .catchError((e) => Response_MODEL(
              message: "Error fetching the operation!\n reason:$e",
              success: false,
            ));
  }

  Future<Response_MODEL> getLastOperation(String device_id) async {
    return await operationsPath
        .where("device_id", isEqualTo: device_id)
        .orderBy("date")
        .limitToLast(1)
        .get()
        .then((value) => Response_MODEL(
            message: "Operations brought successfully!",
            success: true,
            data: value.docs.map((e) {
              e.data()["document_id"] = e.id;
              return e.data();
            }).toList()))
        .catchError((e) => Response_MODEL(
              message: "Error fetching the operation!\n reason:$e",
              success: false,
            ));
  }
}
