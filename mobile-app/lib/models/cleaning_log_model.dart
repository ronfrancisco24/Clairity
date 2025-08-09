import 'package:cloud_firestore/cloud_firestore.dart';
import 'record_timestampped_model.dart';

class CleaningRecord implements TimestampedRecord {
  final String cleaningId;
  final String sensorId;
  final String userId;
  final String comment;
  final int rating;
  final DateTime timestamp;
  final bool acknowledged;
  final String adminMessage;

  CleaningRecord({
    required this.cleaningId,
    required this.sensorId,
    required this.userId,
    required this.comment,
    required this.rating,
    required this.timestamp,
    required this.acknowledged,
    required this.adminMessage,
  });

  factory CleaningRecord.fromFirestore(Map<String, dynamic> data, String id) {
    DateTime parseTimestamp(dynamic ts) {
      if (ts == null) return DateTime.now();
      if (ts is Timestamp) return ts.toDate();
      if (ts is DateTime) return ts;
      if (ts is String) return DateTime.parse(ts);
      throw Exception('Unsupported timestamp type: ${ts.runtimeType}');
    }

    return CleaningRecord(
      cleaningId: id,
      sensorId: data['sensorId'] ?? '',
      userId: data['userId'] ?? '',
      comment: data['comment'] ?? '',
      rating: (data['rating'] ?? 0) is int ? (data['rating'] ?? 0) as int : int.tryParse('${data['rating']}') ?? 0,
      timestamp: parseTimestamp(data['timestamp']),
      acknowledged: data['acknowledged'] ?? false,
      adminMessage: data['adminMessage'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'sensorId': sensorId,
      'userId': userId,
      'comment': comment,
      'rating': rating,
      'timestamp': timestamp, // Firestore accepts DateTime
      'acknowledged': acknowledged,
      'adminMessage': adminMessage,
    };
  }

  CleaningRecord copyWith({
    String? cleaningId,
    String? sensorId,
    String? userId,
    String? comment,
    int? rating,
    DateTime? timestamp,
    bool? acknowledged,
    String? adminMessage,
  }) {
    return CleaningRecord(
      cleaningId: cleaningId ?? this.cleaningId,
      sensorId: sensorId ?? this.sensorId,
      userId: userId ?? this.userId,
      comment: comment ?? this.comment,
      rating: rating ?? this.rating,
      timestamp: timestamp ?? this.timestamp,
      acknowledged: acknowledged ?? this.acknowledged,
      adminMessage: adminMessage ?? this.adminMessage,
    );
  }
}
