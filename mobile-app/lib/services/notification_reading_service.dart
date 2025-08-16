import 'package:cloud_firestore/cloud_firestore.dart';
import '../repositories/notification_repository.dart';
import '../utils/notif_utils.dart';
import '../models/notifications_model.dart';
import '../models/sensor_model_details.dart';
import '../utils/sensor_data_utils.dart';

//TODO: use currentReading and forecastData under reading to determine notifications
//TODO: integrate services across app and reflect on notifications page.
//TODO: make this persist when app is closed or restarted, add persistence and background checks.
//TODO: make sure to generate a different notifications card based on type.
//TODO: make sure to check last time stamp generated to avoid duplicates

class NotificationReadingService {
  final FirebaseFirestore _notifications = FirebaseFirestore.instance;
  final String sensorId;

  NotificationReadingService(this.sensorId);

  //TODO: Take into account for all notifs
  Stream<List<NotificationsModel>> streamNotifications(String type) {
    return _notifications
        .collection('sensors')
        .doc(sensorId)
        .collection('${type}_notifications')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NotificationsModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> addNotification(
      {required String title,
      required String message,
      required int warningLevel,
      required String type}) {
    // determines title based on type
    String finalTitle = type == 'forecast'
        ? 'Forecast Alert: $title'
        : 'Current Reading Alert: $title';

    // determines message based on type
    String finalMessage =
        type == 'forecast' ? 'This is a forecasted alert: $message' : message;

    return _notifications
        .collection('sensors')
        .doc(sensorId)
        .collection('${type}_notifications')
        .add({
      'title': finalTitle,
      'message': finalMessage,
      'warningLevel': warningLevel,
      'type': type,
      'createdAt': Timestamp.now(),
      'isRead': false,
    });
  }

  Future<void> checkThresholdsAndNotify(SensorDetails data,
      {required String type}) async {
    final dataList = currentData(data);
    final aqiLevel = getAqiWarningLevel(data.aqiCategory!);

    for (var item in dataList) {
      final label = item['label'] as String;
      final value = item['value'] as double;
      final max = pollutantMaxValues[label]!;
      // store last value.
      final lastValue = await getLastNotifiedValue(label);

      // if value is greater than threshold, notify user.
      if (value > max && (lastValue == null || value != lastValue)) {
        addNotification(
          title: '$label Alert',
          message: '$label value is $value, exceeding safe limit of $max.',
          warningLevel: aqiLevel,
          type: type,
        );
        await saveLastNotifiedValue(label, value);
      }
    }

    final lastAqi = await getLastNotifiedAqi();
    // if aqi value is higher than threshold, create notification.
    if (['At Risk', 'Unhealthy', 'Hazardous'].contains(data.aqiCategory) &&
        (lastAqi == null || data.aqi != lastAqi)) {
      addNotification(
        title: 'Air Quality Alert',
        message:
            'AQI is ${data.aqi} (${data.aqiCategory}), which exceeds the safe limit.',
        warningLevel: aqiLevel,
        type: type,
      );
      await saveLastNotifiedAqi(data.aqi!);
    }
  }

  // update isRead.
  Future<void> updateIsRead(
      {required String notificationId,
      required bool isRead,
      required String type}) {
    return _notifications
        .collection('sensors')
        .doc(sensorId)
        .collection('${type}_notifications')
        .doc(notificationId)
        .update({'isRead': isRead});
  }

  // delete notification
  Future<void> deleteNotification(
      {required String notificationId, required String type}) {
    return _notifications
        .collection('sensors')
        .doc(sensorId)
        .collection('${type}_notifications')
        .doc(notificationId)
        .delete();
  }

  // CURRENTLY NOT USED
  // NOTE: batches have a limit of 500 write operations, deleting is a write operation

  Future<void> deleteAllNotifications(
      {required String notificationId, required String type}) async {
    final collectionRef = _notifications
        .collection('sensors')
        .doc(sensorId)
        .collection('${type}_notifications');

    final snapshot = await collectionRef.get();

    // store the batch
    final batch = _notifications.batch();

    // for every doc delete in batch
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    // once batch is filled, call commit.
    await batch.commit();
  }
}
