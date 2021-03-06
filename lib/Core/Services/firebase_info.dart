import 'package:swis/Core/Constants/theme_constants.dart';

class ResponseMODEL {
  var data;
  final String? message;
  final bool success;

  ResponseMODEL({this.message, this.success = false, this.data});

  factory ResponseMODEL.fromJson(Map<String, dynamic> _data) {
    return ResponseMODEL(
        data: _data["data"],
        message: _data["message"],
        success: _data["success"]);
  }

  toListModels(Model, {var mainData}) {
    if (mainData == null) mainData = this.data;

    try {
      return mainData.map((thing) => Model.fromJson(thing)).toList();
    } catch (e) {
      snackbar_message("Error:\n toListModel<method> Response_Model<class>  $e");
      print("Error:\n toListModel<method> Response_Model<class>  $e");
      return [];
    }
  }

  toModel(Model, {var mainData}) {
    if (mainData == null) mainData = this.data;

    try {
      return Model.fromJson(mainData);
    } catch (e) {
      snackbar_message("Error:\n toModel<method> Response_Model<class>  $e");
      print("Error:\n toModel<method> Response_Model<class>  $e");
      return Model;
    }
  }
}
