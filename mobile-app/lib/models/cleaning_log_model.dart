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

    factory CleaningRecord.fromJson(Map<String, dynamic> json) {
      return CleaningRecord(
        cleaningId: json['cleaning_id'],
        sensorId: json['sensor_id'],
        userId: json['user_id'],
        comment: json['comment'],
        rating: json['rating'],
        timestamp: DateTime.parse(json['timestamp']),
        acknowledged: json['acknowledged'],
        adminMessage:  json['admin_message']
      );
    }

    CleaningRecord copyWith({
      String? cleaningId,
      String? restroomId,
      String? userId,
      String? comment,
      int? rating,
      DateTime? timestamp,
      String? adminMessage,
    }) {
      return CleaningRecord(
        cleaningId: cleaningId ?? this.cleaningId,
        sensorId: restroomId ?? this.sensorId,
        userId: userId ?? this.userId,
        comment: comment ?? this.comment,
        rating: rating ?? this.rating,
        timestamp: timestamp ?? this.timestamp,
        acknowledged: acknowledged,
        adminMessage: adminMessage ?? this.adminMessage,
      );
    }
  }