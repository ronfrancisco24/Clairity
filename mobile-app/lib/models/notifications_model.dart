import 'package:cloud_firestore/cloud_firestore.dart';

//TODO: record aqi and highest pollutant values.

class NotificationsModel {
  final String id;
  final int warningLevel;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final String type;
  final String sensorId;
  final double aqi;
  final String aqiCategory;

  NotificationsModel({
    required this.id,
    required this.warningLevel,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.isRead,
    required this.type,
    required this.sensorId,
    required this.aqi,
    required this.aqiCategory
  });

  factory NotificationsModel.fromMap(Map<String, dynamic> map, String id) {
    return NotificationsModel(
      id: id,
      timestamp: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      warningLevel: (map['warningLevel'] as num?)?.toInt() ?? 0,
      isRead: map['isRead'] ?? false,
      type: map['type'] ?? '',
      sensorId: map['sensorId'] ?? '',
      aqi: map['aqi'] ?? 0,
      aqiCategory: map['aqiCategory'] ?? '',
    );
  }
}
