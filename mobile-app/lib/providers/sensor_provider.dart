import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/sensor_model_details.dart';
import '../services/notification_reading_service.dart';
import '../services/sensor_reading_service.dart';
import 'user_provider.dart'; // You'll create this model

class SensorProvider extends ChangeNotifier {
  final SensorReadingService _service = SensorReadingService();
  SensorDetails? currentData;
  List<SensorDetails> forecastReadingData = [];

  StreamSubscription? _currentDataSubscription;
  StreamSubscription? _forecastDataSubscription;

  String? readingId;

  SensorProvider(){
    _initializeSensorListener(); // initialize sensor data across screen.
  }

  Future<void> _initializeSensorListener() async {
    final userProvider = UserProvider();
    await userProvider.loadUserData();

    final userId = userProvider.user!.uid;
    final sensors = await SensorReadingService().fetchAllSensorIds();

    if (sensors.isNotEmpty) {
      final sensorId = sensors[0]; // change later to sensorOfChoice, just make it a parameter
      readingId = await SensorReadingService().fetchLatestReadingId(sensorId);

      if (readingId != null) {
        listenToCurrentAndForecastReadings(sensorId, userId);
      } else {
        debugPrint("No latest reading found for sensor $sensorId");
      }
    }
  }

  void listenToCurrentAndForecastReadings(String sensorId, String uid) {
    _currentDataSubscription?.cancel();
    _forecastDataSubscription?.cancel();

    // listen to current data subscription
    _currentDataSubscription =
        _service.streamLatestCleanedReading(sensorId).listen((doc) {
      if (doc.exists) {
        currentData = SensorDetails.fromMap(doc.data());
        notifyListeners();

        // listen to current Data and notify if data exceeds threshold.
        NotificationReadingService(uid)
            .checkThresholdsAndNotify(currentData!, type: 'current');

        // Always listen to forecast from the latest reading
        final latestCleanedId = doc.id;
        _forecastDataSubscription?.cancel(); // cancel old forecast Subscription

        // forecast
        _forecastDataSubscription = _service
            .streamForecastReadings(sensorId,
                latestCleanedId) // associate forecasts with latestCleanedId
            .listen((snapshot) {
          // map each forecast document and store it into forecastReadingData list.
          forecastReadingData = snapshot.docs
              .map((doc) => SensorDetails.fromMap(doc.data()))
              .toList();
          notifyListeners();

          // listen to thresholds in forecast.
          for (var forecast in forecastReadingData) {
            NotificationReadingService(uid)
                .checkThresholdsAndNotify(forecast, type: 'forecast');
          }
        });
      } else {
        print("Nothing is here.");
      }
    });

    @override
    void dispose() {
      _currentDataSubscription?.cancel();
      _forecastDataSubscription?.cancel();
      super.dispose();
    }
  }
}
