  import 'record_timestampped_model.dart';

  class CleaningRecord implements TimestampedRecord {
    final int cleaningId;
    final int restroomId;
    final int userId;
    final String comment;
    final int rating;
    final DateTime timestamp;

    CleaningRecord({
      required this.cleaningId,
      required this.restroomId,
      required this.userId,
      required this.comment,
      required this.rating,
      required this.timestamp,
    });

    factory CleaningRecord.fromJson(Map<String, dynamic> json) {
      return CleaningRecord(
        cleaningId: json['cleaning_id'],
        restroomId: json['restroom_id'],
        userId: json['user_id'],
        comment: json['comment'],
        rating: json['rating'],
        timestamp: DateTime.parse(json['timestamp']),
      );
    }
  }