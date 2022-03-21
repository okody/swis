import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swis/Models/session_model.dart';

class Operation_MODEL {
  final String? document_id;
  final String? state;
  final String? device_id;
  final Timestamp? date;
  final num? tds_readings;
  final num? ph_readings;
  final num? water_flow_rate;
  final num? tank_water_level;
  Session_MODEL session = Session_MODEL();

  Operation_MODEL(
      {this.document_id,
      this.state,
      this.date,
      this.tds_readings,
      this.ph_readings,
      this.water_flow_rate,
      this.tank_water_level,
      this.device_id});

  fromJson(Map<String, dynamic> data) {
    return Operation_MODEL(
      document_id: data["document_id"] ?? "",
      state: data["state"] ?? "",
      date: data["date"] ?? Timestamp.now(),
      tds_readings: data["tds_readings"] ?? 0.0,
      ph_readings: data["ph_readings"] ?? 0.0,
      water_flow_rate: data["water_flow_rate"] ?? 0.0,
      tank_water_level: data["tank_water_level"] ?? 0.0,
      device_id: data["device_id"] ?? "",
    );
  }

  Map<String, dynamic> toStore() {
    return {
      "state": state ?? "",
      "date": date ?? Timestamp.now(),
      "tds_readings": tds_readings ?? 0.0,
      "ph_readings": ph_readings ?? 0.0,
      "water_flow_rate": water_flow_rate ?? 0.0,
      "tank_water_level": tank_water_level ?? 0.0,
      "device_id": device_id ?? "",
    };
  }

  // ========================================== [] ==========================================
  saveOperationSession(List<Session_MODEL> sessions) {
    sessions.forEach((element) {
      if (element.device_id == this.device_id) this.session = element;
    });
  }
}
