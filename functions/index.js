const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { getFirestore } = require("firebase-admin/firestore");
const { getMessaging } = require("firebase-admin/messaging");
const admin = require("firebase-admin");

admin.initializeApp();

// Helper function to send notifications to globally enabled devices
async function sendToEnabledDevices(readingData) {
  const devicesSnap = await getFirestore()
       .collection("devices")
       .where("enabled", "==", true)
       .get();

  if (!readingData || !readingData.sensorId) {
    console.log("Invalid reading data or missing sensorId");
    return;
   }

  if (devicesSnap.empty) {
    console.log(`No enabled device tokens found for sensor ${readingData.sensorId}`);
    return;
  }

  const tokens = devicesSnap.docs.map((doc) => doc.data().token).filter(Boolean);

  const payload = {
    tokens,
    notification: {
      title: readingData.title,
      body: `Sensor ${readingData.sensorId} recorded: ${readingData.message}`,
    },
    // Add data payload for background processing
        data: {
          sensorId: readingData.sensorId,
          type: readingData.type,
        }
  };

  const response = await getMessaging().sendEachForMulticast(payload);

  console.log("Notification sent:", response.successCount, "successful,", response.failureCount, "failed");
}


// Trigger for current notifications
exports.sendSensorNotification = onDocumentCreated(
  "current_notifications/{notificationId}",
  async (event) => {
    const sensorId = event.params.sensorId;
    const readingData = event.data.data();
    await sendToEnabledDevices(readingData);
  }
);

// Trigger for forecast notifications
exports.sendForecastNotification = onDocumentCreated(
  "forecast_notifications/{notificationId}",
  async (event) => {
    const sensorId = event.params.sensorId;
    const readingData = event.data.data();
    await sendToEnabledDevices(readingData);
  }
);
