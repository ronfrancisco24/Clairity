import '../models/notifications_model.dart';
import '../models/sensor_model_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

final _db = FirebaseFirestore.instance;

Stream<List<SensorDetails>> streamSensorHistoryData(String sensorId, DateTime selectedDate) {
  final startOfDay = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
  final endOfDay = startOfDay.add(Duration(days: 1));

  return _db
      .collection('sensors')
      .doc(sensorId)
      .collection('cleanedReadingData')
      .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
      .where('timestamp', isLessThan: endOfDay)
      .orderBy('timestamp')
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs
      .map((doc) => SensorDetails.fromMap(doc.data()))
      .toList());
}

Stream<List<NotificationsModel>> streamAlertData(String sensorId, DateTime selectedDate){
  final startOfDay = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
  final endOfDay = startOfDay.add(const Duration(days: 1));

  return _db
      .collection('sensors')
      .doc(sensorId)
      .collection('current_notifications')
      .where('createdAt', isGreaterThanOrEqualTo: startOfDay)
      .where('createdAt', isLessThan: endOfDay)
      .orderBy('createdAt')
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs
      .map((doc) => NotificationsModel.fromMap(doc.data(), doc.id))
      .toList());
}