import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/notifications_model.dart';
import '../models/sensor_model_details.dart';
import '../utils/sensor_data_utils.dart';

//TODO: use currentReading and forecastData under reading to determine notifications
//TODO: integrate into notifications page
//TODO: create test variables to see if notifications work.
class NotificationReadingService {
  final FirebaseFirestore _notifications = FirebaseFirestore.instance;
  final String userId;

  NotificationReadingService(this.userId); // use userId to read notification.

  Stream<List<NotificationsModel>> streamNotifications() {
    return _notifications
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NotificationsModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  //TODO: add type of notification
  //TODO: notification should have a type whether its a forecast or current reading.
  Future<void> addNotification({
    required String title,
    required String message,
    required int warningLevel,
    required String type,
  }) {
    return _notifications
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .add({
      'title': title,
      'message': message,
      'warningLevel': warningLevel,
      'type': type,
      'timestamp': Timestamp.now(),
      'isRead': false,
    });
  }

  //  TODO: base off the reading from sensorId. use this for forecast and current reading
  //   , however for now use current reading.
  //   also generate a different notification if its from a forecast reading.

  //TODO: make this persist when app is closed or restarted, add persistence and background checks.
  Future<void> checkThresholdsAndNotify(SensorDetails data) async {
    final dataList = currentData(data);
    final aqiLevel = getAqiWarningLevel(data.aqiCategory!);

    for (var item in dataList) {
      final label = item['label'] as String;
      final value = item['value'] as double;
      final max = pollutantMaxValues[label]!;

      // if value is greater than threshold, notify user.
      if (value > max) {
        addNotification(
          title: '$label Alert',
          message: '$label value is $value, exceeding safe limit of $max.',
          warningLevel: aqiLevel,
          type: 'asd', //TODO: change later
        );
      }
    }

    // if aqi value is higher than threshold, create notification.
    if (['At Risk', 'Unhealthy', 'Hazardous'].contains(data.aqiCategory)) {
      addNotification(
        title: 'Air Quality Alert',
        message:
            'AQI is ${data.aqi} (${data.aqiCategory}), which exceeds the safe limit.',
        warningLevel: aqiLevel,
        type: 'asd', //TODO: change later
      );
    }
  }

  Future<void> updateIsRead(String notificationId, bool isRead) {
    return _notifications
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .doc(notificationId)
        .update({'isRead': isRead});
  }

  // delete notification
  Future<void> deleteNotification(String notificationId) {
    return _notifications
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .doc(notificationId)
        .delete();
  }

  // CURRENTLY NOT USED
  // NOTE: batches have a limit of 500 write operations,
  // deleting is a write operation

  Future<void> deleteAllNotifications() async {
    final collectionRef = _notifications
        .collection('users')
        .doc(userId)
        .collection('notifications');

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
