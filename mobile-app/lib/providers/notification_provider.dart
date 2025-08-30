import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/notifications_model.dart';
import '../services/notification_reading_service.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationReadingService _notificationReadingService =
  NotificationReadingService();

  late bool _enabledNotifications;

  List<NotificationsModel> _notificationsList = [];
  List<NotificationsModel> _todaysCurrentNotificationsList = [];
  List<NotificationsModel> _todaysForecastNotificationsList = [];

  StreamSubscription? _allNotificationsSub;
  StreamSubscription? _todaysCurrentSub;
  StreamSubscription? _todaysForecastSub;

  bool get enabledNotifications => _enabledNotifications;

  List<NotificationsModel> get notificationsList => _notificationsList;

  List<NotificationsModel> get todaysCurrentNotificationsList =>
      _todaysCurrentNotificationsList;

  List<NotificationsModel> get todaysForecastNotificationsList =>
      _todaysForecastNotificationsList;

  void isNotificationsEnabled(){
    try {

    } catch (e){

    }
  }

  void listenToNotifications(String type, String sensorId) {
    // Cancel previous subscription if exists
    try {
      _allNotificationsSub?.cancel();

      _allNotificationsSub =
          _notificationReadingService.streamNotifications(type, sensorId).listen((list) {
        _notificationsList = list;
        notifyListeners();
      });
    } catch (e) {
      if (kDebugMode) print('Error fetching notifications: $e');
    }
  }

  void listenToTodaysNotifications(String type, String? sensorId) {
    try {
      if (type == 'current') {
        _todaysCurrentSub?.cancel();
        _todaysCurrentSub = _notificationReadingService
            .streamTodaysNotifications(type, sensorId)
            .listen((list) {
          _todaysCurrentNotificationsList = list;
          notifyListeners();
        });
      } else if (type == 'forecast') {
        _todaysForecastSub?.cancel();
        _todaysForecastSub = _notificationReadingService
            .streamTodaysNotifications(type, sensorId)
            .listen((list) {
          _todaysForecastNotificationsList = list;
          notifyListeners();
        });
      }
    } catch (e) {
      if (kDebugMode) print('Error fetching notifications: $e');
    }
  }

  @override
  void dispose() {
    _allNotificationsSub?.cancel();
    _todaysCurrentSub?.cancel();
    _todaysForecastSub?.cancel();
    super.dispose();
  }
}
