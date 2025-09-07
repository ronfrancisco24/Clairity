import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/aqi_base_utils.dart';

class ForecastedDataModel implements AqiBase {
  @override
  final DateTime timestamp;

  @override
  final double? aqi;

  @override
  final String? aqiCategory;

  ForecastedDataModel.PredictedSensorDetailsModel({
    required this.timestamp,
    required this.aqi,
    required this.aqiCategory,
  });


  factory ForecastedDataModel.fromMap(Map<String, dynamic> map) {
    DateTime parsedTimestamp;

    if (map['predicted_timestamp'] is Timestamp) {
      // Firestore Timestamp
      parsedTimestamp = (map['predicted_timestamp'] as Timestamp).toDate();
    } else if (map['predicted_timestamp'] is String) {
      // ISO 8601 String
      parsedTimestamp = DateTime.tryParse(map['predicted_timestamp']) ?? DateTime.now();
    } else {
      // Fallback
      parsedTimestamp = DateTime.now();
    }

    return ForecastedDataModel.PredictedSensorDetailsModel(
      timestamp: parsedTimestamp,
      aqi: (map['predicted_general_aqi'] as num?)?.toDouble() ?? 0.0, //change to predicted aqi.
      aqiCategory: map['predicted_aqi_category'] as String? ?? 'Unknown',
    );
  }
}