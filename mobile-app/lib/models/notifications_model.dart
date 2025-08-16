import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsModel {
  final String id;
  final int warningLevel;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final String type;

  NotificationsModel(
      {required this.id,
      required this.warningLevel,
      required this.title,
      required this.message,
      required this.timestamp,
      required this.isRead,
      required this.type});

  factory NotificationsModel.fromMap(Map<String, dynamic> map, String id) {
    return NotificationsModel(
        id: id,
        timestamp: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
        title: map['title'] ?? '',
        message: map['message'] ?? '',
        warningLevel: (map['warningLevel'] as num?)?.toInt() ?? 0,
        isRead: map['isRead'] ?? false,
        type: map['type'] ?? '');
  }
}
