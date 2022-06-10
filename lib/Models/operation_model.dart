import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swis/Models/session_model.dart';

class OperationMODEL {
  final String? document_id;
  final String? state;
  final String? device_id;
  final DateTime? date;
  final num? tds_readings;
  final num? ph_readings;
  final num? water_flow_rate;
  final num? water_flow_value;
  final num? water_tank_level;
  SessionMODEL session = SessionMODEL();

  OperationMODEL(
      {this.document_id,
      this.state,
      this.water_flow_value,
      this.date,
      this.tds_readings,
      this.ph_readings,
      this.water_flow_rate,
      this.water_tank_level,
      this.device_id});

  fromJson(Map<String, dynamic> data) {
    return OperationMODEL(
      document_id: data["document_id"] ?? "",
      state: data["state"] ?? "",
      date: data["date"] != null ?  DateTime.parse(data["date"].toDate().toString()) : DateTime.now(),
      tds_readings: data["tds_readings"] ?? 0.0,
      ph_readings: data["ph_readings"] ?? 0.0,
      water_flow_rate: data["water_flow_rate"] ?? 0.0,
       water_flow_value: data["water_flow_value"] ?? 0.0,
      water_tank_level: data["water_tank_level"] ?? 0.0,
      device_id: data["device_id"] ?? "",
      
    );
  }

  // Map<String, dynamic> toStore() {
  //   return {
  //     "state": state ?? "",
  //     "date": date != null ?  DateTime.parse(date) : Timestamp.now(),
  //     "tds_readings": tds_readings ?? 0.0,
  //     "ph_readings": ph_readings ?? 0.0,
  //     "water_flow_rate": water_flow_rate ?? 0.0,
  //     "water_tank_level": water_tank_level ?? 0.0,
  //     "device_id": device_id ?? "",
  //   };
  // }

  // ========================================== [] ==========================================
  saveOperationSession(List<SessionMODEL> sessions) {
    sessions.forEach((element) {
      if (element.device_id == this.device_id) this.session = element;
    });
  }
}
