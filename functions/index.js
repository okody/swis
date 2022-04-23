const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { config } = require("firebase-functions");

admin.initializeApp();


const db = admin.firestore();



exports.operationCreated = functions.database.ref('/operation/{pushId}')
    .onCreate((snapshot, context) => {
      // Grab the current value of what was written to the Realtime Database.
      const operationInfo = snapshot.val();
    

      var payload = { notification: { title: `New Operation: ${operationInfo.ID}`, body: `New Operation of ${operationInfo.GP_Code}` }, data: { click_action: "FLUTTER_NOTIFICATION_CLICK" } }


      const res = await admin.messaging().sendToTopic("Admin", payload);
    });