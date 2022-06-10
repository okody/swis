// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:swis/Core/Services/firebase_info.dart';

class OperationSERVICE {
  final operationsPath = FirebaseFirestore.instance.collection("Operations");


  Future<ResponseMODEL> getOperations(List<String>? devices_list) async {
if(devices_list!.isEmpty) {
  return ResponseMODEL(
      success: true,
      data: []
    );
} else {
  return await operationsPath
    
        .where("device_id", whereIn: devices_list)
        .orderBy("date", descending: true)
        .get()
        .then((value) => ResponseMODEL(
            message: "Operations brought successfully!",
            success: true,
            data: value.docs.map((e) {
              Map document = e.data();
              document["document_id"] = e.id;
              return document;
            }).toList()))
        .catchError((e) => ResponseMODEL(
              message: "Error fetching the operation!\n reason:$e",
              success: false,
            ));
}
  }

  Future<ResponseMODEL> getLastOperation(String device_id) {
    return operationsPath
        .where("device_id", isEqualTo: device_id)
        .orderBy("date" , descending: true)
        .limitToLast(1)
        // .snapshots()
        // .map((snapshot) => ResponseMODEL(
        //     data: snapshot.docs.map((e) => e.data()).toList(), success: true));

        .get()
        .then((value) => ResponseMODEL(
            message: "Operations brought successfully!",
            success: true,
            data: value.docs.map((e) {
              e.data()["document_id"] = e.id;
              return e.data();
            }).toList()))
        .catchError((e) => ResponseMODEL(
              message: "Error fetching the operation!\n reason:$e",
              success: false,
            ));
  }
}
