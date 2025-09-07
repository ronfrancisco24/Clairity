import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import '../utils/dashboard_utils.dart';

class SensorReadingService {
  final _db = FirebaseFirestore.instance;
  final _now = DateTime.now().toUtc().add(const Duration(hours: 8));
  final random = Random();

  Stream<QueryDocumentSnapshot<Map<String, dynamic>>>
      streamLatestCleanedReading(String sensorId) {
    return _db
        .collection('sensors')
        .doc(sensorId)
        .collection('cleaningData') //TODO: change to cleaningData
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) => snapshot.docs.first);
  }

  // gets latestReadingId
  Stream<QueryDocumentSnapshot<Map<String, dynamic>>> fetchLatestPredictionId(String sensorId) {
    return _db
        .collection('sensors')
        .doc(sensorId)
        .collection('predictedData')
        .orderBy('predicted_timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) => snapshot.docs.first);
  }

  Future<List<String>> fetchAllSensorIds() async {
    final snapshot = await _db.collection('sensors').get();

    // This returns a list of document IDs (sensor IDs)
    return snapshot.docs.map((doc) => doc.id).toList();
  }

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
          .collection('cleaningData') //TODO: change to cleaningData
          .doc(cleanedDocId);

      await cleanedRef.set(testData);

      final forecastTime = readingTime.add(const Duration(minutes: 60));
      final forecastData = generatePredictedValues(forecastTime);

      final predictedDataId = '${rawId}_predicted';

      await _db
          .collection('sensors')
          .doc(sensorId)
          .collection('predictedData')
          .doc(predictedDataId)
          .set(forecastData);
    }
    print('Test data generated successfully');
  }

  // generate random sensor values for testing
  Map<String, dynamic> generateSensorValues(DateTime time) {
    final aqiValue = random.nextInt(200);
    return {
      'timestamp': Timestamp.fromDate(time),
      'temp': double.parse((20 + random.nextDouble() * 10).toStringAsFixed(1)),
      'humidity':
          double.parse((30 + random.nextDouble() * 40).toStringAsFixed(1)),
      'co': double.parse((random.nextDouble() * 50).toStringAsFixed(1)),
      'co2':
          double.parse((400 + random.nextDouble() * 20000).toStringAsFixed(1)),
      'ch4': double.parse((random.nextDouble() * 6).toStringAsFixed(1)),
      'tvoc': double.parse((random.nextDouble() * 5500).toStringAsFixed(1)),
      'general_aqi': aqiValue,
      'aqi_category': getAqiCategory(aqiValue),
      'pm25': double.parse((random.nextDouble() * 500).toStringAsFixed(1)),
      'h2s': double.parse((random.nextDouble() * 10).toStringAsFixed(1)),
      'nh3': double.parse((random.nextDouble() * 10).toStringAsFixed(1)),
    };
  }

  Map<String, dynamic> generatePredictedValues(DateTime time) {
    final aqiValue = random.nextInt(200);
    return {
      'predicted_timestamp': Timestamp.fromDate(time),
      'predicted_general_aqi': aqiValue,
      'predicted_aqi_category': getAqiCategory(aqiValue),
    };
  }
}
