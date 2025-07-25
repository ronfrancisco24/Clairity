import 'package:flutter/foundation.dart';
import '../models/cleaning_log_model.dart';

class LogProvider with ChangeNotifier {
  final List<CleaningRecord> _logs = [];

  List<CleaningRecord> get logs => List.unmodifiable(_logs);

  void addLog(CleaningRecord record) {
    _logs.add(record);
    notifyListeners();
  }

  void removeLog(int cleaningId) {
    _logs.removeWhere((log) => log.cleaningId == cleaningId);
    notifyListeners();
  }

  void clearLogs() {
    _logs.clear();
    notifyListeners();
  }
}