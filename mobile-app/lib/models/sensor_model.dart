import 'package:cloud_firestore/cloud_firestore.dart';

class SensorDetails {
  final DateTime timestamp;
  final double pm25;
  final double co;
  final double nh3;
  final double h2s;
  final double ch4;
  final double co2;
  final double vocs;
  final double temp;
  final double humidity;
  final double? aqi;
  final String? aqiCategory;

  SensorDetails({
    required this.timestamp,
    required this.pm25,
    required this.co,
    required this.nh3,
    required this.h2s,
    required this.ch4,
    required this.co2,
    required this.vocs,
    required this.temp,
    required this.humidity,
    this.aqi,
    this.aqiCategory,
  });


  factory SensorDetails.fromMap(Map<String, dynamic> map) {
    return SensorDetails(
      timestamp: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      pm25: (map['pm25'] as num?)?.toDouble() ?? 0.0,
      co: (map['co'] as num?)?.toDouble() ?? 0.0,
      nh3: (map['nh3'] as num?)?.toDouble() ?? 0.0,
      h2s: (map['h2s'] as num?)?.toDouble() ?? 0.0,
      ch4: (map['ch4'] as num?)?.toDouble() ?? 0.0,
      co2: (map['co2'] as num?)?.toDouble() ?? 0.0,
      vocs: (map['tvoc'] as num?)?.toDouble() ?? 0.0,
      temp: (map['temp'] as num?)?.toDouble() ?? 0.0,
      humidity: (map['humidity'] as num?)?.toDouble() ?? 0.0,
      aqi: (map['aqi'] as num?)?.toDouble() ?? 0.0,
      aqiCategory: map['aqiCategory'] as String? ?? 'Unknown',
    );
  }
}