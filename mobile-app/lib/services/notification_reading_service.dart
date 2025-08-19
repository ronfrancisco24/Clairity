import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../utils/notif_utils.dart';
import '../models/notifications_model.dart';
import '../models/sensor_model_details.dart';
import '../utils/sensor_data_utils.dart';

//TODO: make this persist when app is closed or restarted, add persistence and background checks.
//TODO: make sure to check last time stamp generated to avoid duplicates

class NotificationReadingService {
  final FirebaseFirestore _notifications = FirebaseFirestore.instance;
  final String sensorId;

  // use to send notifications for every 10 minutes
  static final Map<String, DateTime> _lastNotified = {};

  NotificationReadingService(this.sensorId);

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

  //TODO: use for fetching 30 and 60 minute sensor forecasts
  Future<List<Map<String, dynamic>>> fetchFilteredForecasts(String sensorId) async {
    final snapshot = await _notifications
        .collection('sensors')
        .doc(sensorId)
        .collection('cleanedReadingData')
        .get();

    List<Map<String, dynamic>> results = [];

    for (final cleanedDoc in snapshot.docs) {
      final forecastSnapshot = await cleanedDoc.reference
          .collection('forecast')
          .get();

      // Keep only 30 and 60 minute forecasts
      for (final doc in forecastSnapshot.docs) {
        if (doc.id.contains('30mins') || doc.id.contains('60mins')) {
          results.add(doc.data());
        }
      }
    }

    return results;
  }

  Future<void> addNotification(
      {required String title,
      required String message,
      required int warningLevel,
      required String type,
      required String dedupId}) async {

    // determines title based on type
    String finalTitle = type == 'forecast'
        ? 'Forecast Alert: $title'
        : 'Current Reading Alert: $title';

    // determines message based on type
    String finalMessage =
        type == 'forecast' ? 'This is a forecasted alert: $message' : message;

    final exists = await _notifications
        .collection('sensors')
        .doc(sensorId)
        .collection('${type}_notifications')
        .where('dedupId', isEqualTo: dedupId)
        .limit(1)
        .get();

    if (exists.docs.isNotEmpty) {
      debugPrint("Duplicate notification skipped: $dedupId");
      return;
    }

    await _notifications
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
      'dedupId': dedupId
    });
  }

  // notify every 15 minutes.
  bool _shouldNotify(String key, {Duration cooldown = const Duration(seconds: 20)}) {
    final last = _lastNotified[key];
    if (last == null || DateTime.now().difference(last) > cooldown) {
      _lastNotified[key] = DateTime.now();
      return true;
    }
    return false;
  }

  Future<void> checkThresholdsAndNotify(SensorDetails data,
      {required String type}) async {
    final dataList = currentData(data);
    final aqiLevel = getAqiWarningLevel(data.aqiCategory!);

    for (int i = 0; i < dataList.length; i++) {
      final item = dataList[i];
      final label = item['label'] as String;
      final value = item['value'] as double;
      final max = pollutantMaxValues[label]!;

      // generate a unique key per reading
      final pollutantKey = "$sensorId-$type-$label-$i";

      if (value > max && _shouldNotify(pollutantKey, cooldown: const Duration(seconds: 20))) {
        addNotification(
            title: '$label Alert',
            message: '$label value is $value, exceeding safe limit of $max.',
            warningLevel: aqiLevel,
            type: type,
            dedupId: pollutantKey
        );
      }
    }

    // AQI notification
    // AQI notification (FIXED)
    final aqiKey = "$sensorId-$type-aqi-${data.timestamp.millisecondsSinceEpoch}";

    if (['At Risk', 'Unhealthy', 'Hazardous'].contains(data.aqiCategory) &&
        _shouldNotify(aqiKey, cooldown: Duration(minutes: 10))) {
      addNotification(
          title: 'Air Quality Alert',
          message: 'AQI is ${data.aqi} (${data.aqiCategory})',
          warningLevel: aqiLevel,
          type: type,
          dedupId: aqiKey
      );
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
        .update({'isRead': true});
  }

}
