import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class SensorReadingService {
  final _db = FirebaseFirestore.instance;
  final _now = DateTime.now();
  final random = Random();

  //TODO: once documents are populated use QuerySnapshot to read multiple docs
  //TODO: always base off the current document
  Stream<QueryDocumentSnapshot<Map<String, dynamic>>> streamLatestReading(String sensorId) {
    return _db
        .collection('sensors')
        .doc(sensorId)
        .collection('readings')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) => snapshot.docs.first);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamForecastReadings(
      String sensorId, String readingId) {
    return _db
        .collection('sensors')
        .doc(sensorId)
        .collection('readings')
        .doc(readingId)
        .collection('forecast')
        .orderBy('timestamp')
        .snapshots();
  }

  // gets latestReadingId
  Future<String?> fetchLatestReadingId(String sensorId) async {
    final snapshot = await _db
        .collection('sensors')
        .doc(sensorId)
        .collection('readings')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.id;
    }

    return null;
  }

  // for testing purposes, generate 8 documents under readings
  // TODO: use to test history for sensor data.
  Future<void> generateTestSensorData(String sensorId) async {
    for (int i = 0; i < 8; i++) {
      final readingTime = _now.subtract(Duration(hours: i * 3));
      final testData = generateSensorValues(readingTime);

      // Add the reading document
      final readingRef = await _db
          .collection('sensors')
          .doc(sensorId)
          .collection('readings')
          .add(testData);

      // Add 4 forecast documents
      for (int j = 1; j <= 4; j++) {
        final forecastTime = readingTime.add(Duration(minutes: j * 30));
        final forecastData = generateSensorValues(forecastTime);

        await readingRef
            .collection('forecast')
            .doc('forecast$j')
            .set(forecastData);
      }
    }

    print('Test data generated successfully');
  }

  // generate random sensor values
  Map<String, dynamic> generateSensorValues(DateTime time) {
    return {
      'timestamp': Timestamp.fromDate(time),
      'temp': double.parse((20 + random.nextDouble() * 10).toStringAsFixed(1)),
      'humidity': double.parse((30 + random.nextDouble() * 40).toStringAsFixed(1)),
      'co': double.parse((random.nextDouble() * 10).toStringAsFixed(1)),
      'co2': double.parse((400 + random.nextDouble() * 600).toStringAsFixed(1)),
      'ch4': double.parse((random.nextDouble() * 1000).toStringAsFixed(1)),
      'tvoc': double.parse((random.nextDouble() * 600).toStringAsFixed(1)),
      'aqi': random.nextInt(500),
      'aqiCategory': getAqiCategory(random.nextInt(500)),
      'pm25': double.parse((random.nextDouble() * 100).toStringAsFixed(1)),
      'h2s': double.parse((random.nextDouble() * 10).toStringAsFixed(1)),
      'nh3': double.parse((random.nextDouble() * 50).toStringAsFixed(1)),
    };
  }
}

String getAqiCategory(int aqi) {
  if (aqi <= 50) return 'Good';
  if (aqi <= 100) return 'Moderate';
  if (aqi <= 200) return 'Unhealthy';
  return 'Hazardous';
}
