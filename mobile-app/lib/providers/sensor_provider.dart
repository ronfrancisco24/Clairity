import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/sensor_model_details.dart';
import '../services/notification_reading_service.dart';
import '../services/sensor_reading_service.dart';
import 'user_provider.dart'; // You'll create this model

//TODO: change later to sensorOfChoice in initializeSensorListener, just make it a parameter

class SensorProvider extends ChangeNotifier {
  final SensorReadingService _service = SensorReadingService();
  late final NotificationReadingService _notifService;
  SensorDetails? currentData;
  List<SensorDetails> forecastReadingData = [];
  StreamSubscription? _currentDataSubscription;
  StreamSubscription? _forecastDataSubscription;
  String? readingId;
  String? currentSensor;

  Future<void> getCurrentSensor() async {
    print('');
  }

  Future<void> initializeSensorListener([String? sensorId]) async {
    if (_currentDataSubscription != null || _forecastDataSubscription != null) {
      debugPrint("Sensor listener already initialized, skipping...");
      return;
    }

    final userProvider = UserProvider();
    await userProvider.loadUserData();

      final chosenSensor = sensorId ?? 'YDTdkdd2dSFsw6dtyvjd';
      readingId = await _service.fetchLatestReadingId(chosenSensor);

      if (readingId != null) {
        listenToCurrentAndForecastReadings(chosenSensor);
      } else {
        debugPrint("No latest reading found for sensor $chosenSensor");
      }

  }

  void listenToCurrentAndForecastReadings(String sensorId) {
    _currentDataSubscription?.cancel();
    _forecastDataSubscription?.cancel();

    _notifService = NotificationReadingService(sensorId);

    _currentDataSubscription =
        _service.streamLatestCleanedReading(sensorId).listen((doc) {
      if (doc.exists) {
        currentData = SensorDetails.fromMap(doc.data());
        notifyListeners();

        final latestCleanedId = doc.id;
        _forecastDataSubscription?.cancel();

        // STEP 2: Initialize forecast data first
        _forecastDataSubscription = _service
            .streamForecastReadings(sensorId, latestCleanedId)
            .listen((snapshot) {
          // Initialize forecast data
          forecastReadingData = snapshot.docs
              .map((doc) => SensorDetails.fromMap(doc.data()))
              .toList();
          notifyListeners();

          print(forecastReadingData);

          _forecastDataChecks();
        });

        _currentDataChecks();
      } else {
        print("Nothing is here.");
      }
    });
  }

  void _currentDataChecks() {
    if (currentData != null) {
      _notifService.checkThresholdsAndNotify(currentData!, type: 'current');
    }
  }

  void _forecastDataChecks() {
    for (var forecast in forecastReadingData) {
      _notifService.checkThresholdsAndNotify(forecast, type: 'forecast');
    }
  }

  void disposeListeners() {
    _currentDataSubscription?.cancel();
    _forecastDataSubscription?.cancel();
    _currentDataSubscription = null;
    _forecastDataSubscription = null;
    debugPrint("Sensor listeners disposed");
  }
}
