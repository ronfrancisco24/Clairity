import 'package:flutter/foundation.dart';
import '../models/cleaning_log_model.dart';

class LogProvider with ChangeNotifier {
  final List<CleaningRecord> _logs = [];

  List<CleaningRecord> get logs => List.unmodifiable(_logs);

  void addLog(CleaningRecord record) {
    _logs.add(record);
    notifyListeners();
  }

  void editLog(CleaningRecord updatedRecord) {
    final index = _logs.indexWhere((log) => log.cleaningId == updatedRecord.cleaningId);
    if (index != -1) {
      _logs[index] = updatedRecord;
      notifyListeners();
    }
  }

  void removeLog(String cleaningId) {
    _logs.removeWhere((log) => log.cleaningId == cleaningId);
    notifyListeners();
  }

  void clearLogs() {
    _logs.clear();
    notifyListeners();
  }
}