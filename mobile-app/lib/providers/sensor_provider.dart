import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/sensor_model.dart';
import '../services/sensor_reading_service.dart'; // You'll create this model

class SensorProvider extends ChangeNotifier {
  //TODO: implement current readings from sensor_reading_service
  //TODO: after accessing current data from sensor_service use SensorDetails from sensor_model.dart\
  //TODO: adjust to new structure of app.

  final SensorReadingService _service = SensorReadingService();
  SensorDetails? currentData;
  List<SensorDetails> forecastReadingData = [];

  StreamSubscription? _currentDataSubscription;
  StreamSubscription? _forecastDataSubscription;

  void listenToSensor(String sensorId) {
    _currentDataSubscription?.cancel();
    _forecastDataSubscription?.cancel();

    // listen to current data subscription
    _currentDataSubscription =
        _service.streamLatestCleanedReading(sensorId).listen((doc) {
          if (doc.exists) {
            currentData = SensorDetails.fromMap(doc.data());
            notifyListeners();

            // Always listen to forecast from the latest reading
            final latestCleanedId = doc.id;
            _forecastDataSubscription?.cancel(); // cancel old forecast Subscription

            // forecast
            _forecastDataSubscription = _service
                .streamForecastReadings(sensorId, latestCleanedId)
                .listen((snapshot) {
              forecastReadingData =
                  snapshot.docs.map((doc) => SensorDetails.fromMap(doc.data())).toList();
              notifyListeners();
            });
          } else {
            print("Nothing is here.");
          }
        });
  }

  @override
  void dispose() {
    _currentDataSubscription?.cancel();
    _forecastDataSubscription?.cancel();
    super.dispose();
  }
}
