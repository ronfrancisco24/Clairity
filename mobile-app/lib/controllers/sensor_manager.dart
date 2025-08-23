import 'dart:async';
import '../models/sensor_model_details.dart';
import '../providers/sensor_provider.dart';
import '../services/notification_reading_service.dart';
import '../services/sensor_reading_service.dart';

class SensorManager {
  final SensorProvider provider;
  final NotificationReadingService _notifService;
  StreamSubscription? _currentDataSub;
  StreamSubscription? _forecastDataSub;

  SensorManager({required this.provider, required String sensorId})
  : _notifService = NotificationReadingService();

  void startListening(String sensorId) {
    _currentDataSub = SensorReadingService()
        .streamLatestCleanedReading(sensorId)
        .listen((doc) {
      if (doc.exists) {
        provider.setCurrentData(SensorDetails.fromMap(doc.data()));

        final latestCleanedId = doc.id;

        _forecastDataSub?.cancel();
        _forecastDataSub = SensorReadingService()
            .streamForecastReadings(sensorId, latestCleanedId)
            .listen((snapshot) {
          provider.setForecastData(
            snapshot.docs.map((doc) => SensorDetails.fromMap(doc.data())).toList(),
          );

          _checkForecastNotifications(sensorId);
        });

        _checkCurrentNotification(sensorId);
      }
    });
  }


  void _checkCurrentNotification(String sensorId) {
    if (provider.currentData != null) {
      _notifService.checkThresholdsAndNotify(provider.currentData!, type: 'current', sensorId);
    }
  }

  void _checkForecastNotifications(String sensorId) {
    for (var forecast in provider.forecastReadingData) {
      _notifService.checkThresholdsAndNotify(forecast, type: 'forecast', sensorId);
    }
  }

  void dispose() {
    _currentDataSub?.cancel();
    _forecastDataSub?.cancel();
  }

}