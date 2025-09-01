import 'dart:async';
import '../models/forecasted_sensor_data_model.dart';
import '../models/sensor_data_model.dart';
import '../providers/sensor_provider.dart';
import '../services/notification_reading_service.dart';
import '../services/sensor_reading_service.dart';

//TODO: set forecast data sub to predicted data model.

class SensorManager {
  final SensorProvider provider;
  final NotificationReadingService _notifService;
  StreamSubscription? _currentDataSub;
  StreamSubscription? _predictedDataSub; //change this to forecastDataSub later.

  SensorManager({required this.provider, required String sensorId})
      : _notifService = NotificationReadingService();

  void startListening(String sensorId) {
    _currentDataSub = SensorReadingService()
        .streamLatestCleanedReading(sensorId)
        .listen((doc) {
      if (doc.exists) {
        provider.setCurrentData(SensorDataModel.fromMap(doc.data()));
        _checkCurrentNotification(sensorId);
      }

    });

    _predictedDataSub?.cancel();
    _predictedDataSub = SensorReadingService()
        .fetchLatestPredictionId(sensorId)
        .listen((doc) {
      if (doc.exists) {
        provider.setPredictedData(ForecastedDataModel.fromMap(doc.data()));
      }
    });

    _checkPredictionNotifications(sensorId);
  }

  void _checkCurrentNotification(String sensorId) {
    if (provider.currentData != null) {
      _notifService.checkThresholdsAndNotify(
          provider.currentData!, type: 'current', sensorId);
    }
  }

  void _checkPredictionNotifications(String sensorId) {
    if (provider.predictedData != null) {
      _notifService.checkThresholdsAndNotify(
          provider.predictedData!, type: 'forecast', sensorId);
    }
    print('i predicted data!');
  }

  void dispose() {
    _currentDataSub?.cancel();
    _predictedDataSub?.cancel();
  }
}
