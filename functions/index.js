const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { getFirestore } = require("firebase-admin/firestore");
const { getMessaging } = require("firebase-admin/messaging");
const admin = require("firebase-admin");

admin.initializeApp();

// Helper function to send notifications to globally enabled devices
async function sendToEnabledDevices(sensorId, readingData) {
  const devicesSnap = await getFirestore()
       .collection("devices")
       .where("enabled", "==", true)
       //.where("sensorId", "==", sensorId) // optional if devices are per sensor
       .get();

  if (devicesSnap.empty) {
    console.log(`No enabled device tokens found for sensor ${sensorId}`);
    return;
  }

  const tokens = devicesSnap.docs.map((doc) => doc.data().token).filter(Boolean);

  const payload = {
    tokens,
    notification: {
      title: readingData.title,
      body: `Sensor ${sensorId} recorded: ${readingData.message}`,
    },
  };

  const response = await getMessaging().sendEachForMulticast(payload);

  console.log("Notification sent:", response.successCount, "successful,", response.failureCount, "failed");
}


// Trigger for current notifications
exports.sendSensorNotification = onDocumentCreated(
  "sensors/{sensorId}/current_notifications/{notificationId}",
  async (event) => {
    const sensorId = event.params.sensorId;
    const readingData = event.data.data();
    await sendToEnabledDevices(sensorId, readingData);
  }
);

// Trigger for forecast notifications
exports.sendForecastNotification = onDocumentCreated(
  "sensors/{sensorId}/forecast_notifications/{notificationId}",
  async (event) => {
    const sensorId = event.params.sensorId;
    const readingData = event.data.data();
    await sendToEnabledDevices(sensorId, readingData);
  }
);
