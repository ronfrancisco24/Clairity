const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { getFirestore } = require("firebase-admin/firestore");
const { getMessaging } = require("firebase-admin/messaging");
const admin = require("firebase-admin");

admin.initializeApp();

// Firestore trigger on new notification doc
exports.sendSensorNotification = onDocumentCreated(
  "sensors/{sensorId}/current_notifications/{notificationId}",
  async (event) => {
    const sensorId = event.params.sensorId;
    const readingData = event.data.data();

    // 1. Get device tokens from deviceTokens subcollection
    const tokensSnap = await getFirestore()
      .collection("sensors")
      .doc(sensorId)
      .collection("deviceTokens")
      .get();

    if (tokensSnap.empty) {
      console.log(`No tokens found for sensor ${sensorId}`);
      return null;
    }

    const tokens = tokensSnap.docs.map((doc) => doc.id);

    // 2. Build notification payload
    const payload = {
      notification: {
        title: "New Sensor Notification",
        body: `Sensor ${sensorId} recorded: ${JSON.stringify(readingData)}`,
      },
    };

    // 3. Send notification
    const response = await getMessaging().sendEachForMulticast({
      tokens,
      ...payload,
    });

    console.log("Notification sent:", response);
    return null;
  }
);
