import '../models/notifications_model.dart';
import '../models/sensor_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _db = FirebaseFirestore.instance;

Stream<List<SensorDataModel>> streamSensorHistoryData(String sensorId, DateTime selectedDate) {
  final startOfDay = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
  final endOfDay = startOfDay.add(const Duration(days: 1));

  return _db.collection('sensors')
      .doc(sensorId)
      .collection('cleaningData')
      .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
      .where('timestamp', isLessThan: endOfDay)
      .orderBy('timestamp')
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs
      .map((doc) => SensorDataModel.fromMap(doc.data()))
      .toList());
}

Stream<List<NotificationsModel>> streamAlertData(String sensorId, DateTime selectedDate){
  final startOfDay = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
  final endOfDay = startOfDay.add(const Duration(days: 1));

  return _db
      .collection('current_notifications')
      .where('createdAt', isGreaterThanOrEqualTo: startOfDay)
      .where('createdAt', isLessThan: endOfDay)
      .orderBy('createdAt')
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs
      .map((doc) => NotificationsModel.fromMap(doc.data(), doc.id))
      .toList());
}

