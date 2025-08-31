import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/cleaning_log_model.dart';
import '../services/log_records_service.dart';

class LogProvider with ChangeNotifier {
  final List<CleaningRecord> _logs = [];
  final LogRecordsService _service = LogRecordsService();
  DateTime? _lastCleanedTime;

  DateTime? get lastCleanedTime => _lastCleanedTime;
  List<CleaningRecord> get logs => List.unmodifiable(_logs);

  StreamSubscription<CleaningRecord>? _subscription;

  Future<void> fetchLogs() async {
    try {
      final fetchedLogs = await _service.fetchLogs();
      _logs
        ..clear()
        ..addAll(fetchedLogs);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print("Error fetching logs: $e");
    }
  }

  void listenToLatestCleanedTime(String sensorId) {
    try {
      _subscription?.cancel();

      _subscription = _service.fetchLastCleanedTime(sensorId).listen((record) {
        _lastCleanedTime = record.timestamp;
        notifyListeners();
      });
    } catch (e) {
      if (kDebugMode) print("Error fetching logs: $e");
    }
  }

  Future<void> addLog(CleaningRecord record) async {
    try {
      final newRecord = await _service.addLog(record);
      _logs.add(newRecord);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print("Error adding log: $e");
    }
  }

  Future<void> editLog(CleaningRecord updatedRecord) async {
    try {
      await _service.editLog(updatedRecord);
      final index = _logs.indexWhere((log) => log.cleaningId == updatedRecord.cleaningId);
      if (index != -1) {
        _logs[index] = updatedRecord;
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) print("Error updating log: $e");
    }
  }

  Future<void> updateLog(String cleaningId, {required bool acknowledged, required String adminMessage}) async {
    try {
      await _service.updateLog(cleaningId, acknowledged: acknowledged, adminMessage: adminMessage);
      final index = _logs.indexWhere((log) => log.cleaningId == cleaningId);
      if (index != -1) {
        _logs[index] = _logs[index].copyWith(
          acknowledged: acknowledged,
          adminMessage: adminMessage,
        );
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) print("Error updating log: $e");
    }
  }

  Future<void> removeLog(String cleaningId) async {
    try {
      await _service.removeLog(cleaningId);
      _logs.removeWhere((log) => log.cleaningId == cleaningId);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print("Error deleting log: $e");
    }
  }
}