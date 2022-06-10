const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { config, firebaseConfig } = require("firebase-functions");

admin.initializeApp();


const db = admin.firestore();

exports.copyDevices = functions.database.ref('/Devices/{tank_id}')
    .onCreate(async (snapshot, context) => {
      // Grab the current value of what was written to the Realtime Database.
      // copyDevices({"access_key": "123123" , "id": "tank002" , "isConnected": true})
      const device_info = snapshot.val();

      await db.collection("Devices").doc(device_info.id).set(
      {
        "id": device_info.id,
        "access_key": device_info.access_key,
        "date": new Date(),
        "isConnected": device_info.isConnected,
        "tank_depth": 400
      }
      );

    });


    exports.copyOperations = functions.database.ref('/Operations/{operation_id}')
    .onCreate(async (snapshot, context) => {
      // Grab the current value of what was written to the Realtime Database.
      // copyOperations({"device_id": "tank001" , "ph_readings": 9.7 , "tds_readings": 320 , "water_flow_rate": 15 , "distance": 5 })
      const operation_info = snapshot.val();

      

    
      

      const sessions = await db.collection("Sessions").where("device_id" , "==" , operation_info.device_id).get();
      const device = await db.collection("Devices").where("id" , "==" , operation_info.device_id).get();
      const configuration = await db.collection("Configuration").doc("sensorsDangerThreshold").get();


     
      // functions.logger.log(configuration.data().ph_sensor["min"] );



    //   /// check for dangers
       var notificationBody = "";
      var notificationTitle = `Warning, last refilling of the tank with ID: ${operation_info.device_id} `;
      var isWarning = false;
      

      if(operation_info.ph_readings < configuration.data().ph_sensor["max"] || operation_info.ph_readings < configuration.data().ph_sensor["min"])
        {
        notificationBody += `Ph sensor readings are very low or very high: ${operation_info.ph_readings}\n`;
        isWarning = true;
        }
      if (operation_info.tds_readings >= configuration.data().tds_sensor)
      {
        notificationBody += `Tds sensor readings are very high: ${operation_info.tds_readings} ppm\n`;
        isWarning = true;
      }
      if ((operation_info.water_flow_rate / configuration.data().max_flow_rate) <= configuration.data().flow_rate_sensor)
      {
        notificationBody += `Water flow rate sensor readings are very low: ${operation_info.water_flow_rate} cms\n`;
        isWarning = true;
      }
      if(!isWarning)
      {
        notificationTitle = `Successful refilling of tank with id: ${operation_info.device_id} `;
        notificationBody = `Successful refilling of tank with id: ${operation_info.device_id} `;
      }

      const water_tank_level = ((operation_info.distance - device.docs[0].data().tank_depth)*-2)/  device.docs[0].data().tank_depth ;
      

      await db.collection("Operations").add({
        "device_id": operation_info.device_id,

        "state": isWarning ? "Unsuccessful" : "Successful",
        "tds_readings": operation_info.tds_readings,
        "ph_readings": operation_info.ph_readings,
        "water_flow_rate": operation_info.water_flow_rate / configuration.data().max_flow_rate,
        "water_flow_value": operation_info.water_flow_rate,
        "water_tank_level": water_tank_level > 1 ? 1 : water_tank_level ,

        "date": new Date()
      });
   

      await db.collection("Notifications").add(
        {
          "device_id": operation_info.device_id,
          "title": notificationTitle,
          "content": notificationBody,

          "date": new Date()
        }
      );
      

      
      

      var Tokens = ["Test"];
    for (var token of sessions.docs)
        Tokens.push(token.data().phone_token.trim());



    
      var payload = { notification: { title: notificationTitle, body: notificationBody }, data: { click_action: "FLUTTER_NOTIFICATION_CLICK" } }
      const res = await admin.messaging().sendToDevice(Tokens, payload);
     

    });





