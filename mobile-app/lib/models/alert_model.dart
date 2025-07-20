import 'record_timestampped_model.dart';

class AlertLog implements TimestampedRecord {
  final int alertId;
  final int restroomId;
  final double description;
  final int level;
  final DateTime timestamp;

  AlertLog({
    required this.alertId,
    required this.restroomId,
    required this.description,
    required this.level,
    required this.timestamp,
  });

  factory AlertLog.fromJson(Map<String, dynamic> json) {
    return AlertLog(
      alertId: json['alert_id'],
      restroomId: json['restroom_id'],
      description: json['description'].toDouble(),
      level: json['level'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alert_id': alertId,
      'restroom_id': restroomId,
      'description': description,
      'level': level,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
