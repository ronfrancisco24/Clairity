import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import '../utils/dashboard_utils.dart';

class SensorReadingService {
  final _db = FirebaseFirestore.instance;
  final _now = DateTime.now();
  final random = Random();

  Stream<QueryDocumentSnapshot<Map<String, dynamic>>> streamLatestCleanedReading(String sensorId) {
    return _db
        .collection('sensors')
        .doc(sensorId)
        .collection('cleanedReadingData')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) => snapshot.docs.first);
  }

  //TODO: use one document instead.
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamForecastReading(
      String sensorId, String cleanReadingId) {
    final forecastId = '${cleanReadingId}_60mins';
    return _db
        .collection('sensors')
        .doc(sensorId)
        .collection('cleanedReadingData')
        .doc(cleanReadingId)
        .collection('forecast')
        .doc(forecastId)
        .snapshots();
  }

  // gets latestReadingId
  Future<String?> fetchLatestReadingId(String sensorId) async {
    final snapshot = await _db
        .collection('sensors')
        .doc(sensorId)
        .collection('cleanedReadingData')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.id;
    }

    return null;
  }

  Future<List<String>> fetchAllSensorIds() async {
    final snapshot = await _db.collection('sensors').get();

    // This returns a list of document IDs (sensor IDs)
    return snapshot.docs.map((doc) => doc.id).toList();
  }

  //TODO: generate until 60 minutes only.
  // for testing purposes, generate 8 documents under readings
  Future<void> generateRawTestData(String sensorId) async {
    for (int i = 0; i < 8; i++) {
      final readingTime = _now.subtract(Duration(hours: i * 3));
      final testData = generateSensorValues(readingTime);

      // Raw Data

      final rawRef = await _db
          .collection('sensors')
          .doc(sensorId)
          .collection('rawReadingData')
          .add(testData);

      final rawId = rawRef.id;

      final cleanedDocId = '${rawId}_clean';

      // Cleaned Data
      final cleanedRef = _db
          .collection('sensors')
          .doc(sensorId)
          .collection('cleanedReadingData')
          .doc(cleanedDocId);

      await cleanedRef.set(testData);
      // for (int j = 1; j <= 4; j++) {
      final forecastTime = readingTime.add(Duration(minutes: 60));
      final forecastData = generateSensorValues(forecastTime);
      final forecastDataId = '${cleanedDocId}_60mins';

      await cleanedRef
          .collection('forecast')
          .doc(forecastDataId)
          .set(forecastData);
      // }
    }
    print('Test data generated successfully');
  }

  // generate random sensor values
  Map<String, dynamic> generateSensorValues(DateTime time) {
    final aqiValue = random.nextInt(500);

    return {
      'timestamp': Timestamp.fromDate(time),
      'temp': double.parse((20 + random.nextDouble() * 10).toStringAsFixed(1)),
      'humidity': double.parse((30 + random.nextDouble() * 40).toStringAsFixed(1)),
      'co': double.parse((random.nextDouble() * 50).toStringAsFixed(1)),
      'co2': double.parse((400 + random.nextDouble() * 18000).toStringAsFixed(1)),
      'ch4': double.parse((random.nextDouble() * 19).toStringAsFixed(1)),
      'tvoc': double.parse((random.nextDouble() * 5500).toStringAsFixed(1)),
      'aqi': aqiValue,
      'aqiCategory': getAqiCategory(aqiValue),
      'pm25': double.parse((random.nextDouble() * 500).toStringAsFixed(1)),
      'h2s': double.parse((random.nextDouble() * 60).toStringAsFixed(1)),
      'nh3': double.parse((random.nextDouble() * 50).toStringAsFixed(1)),
    };
  }
}


