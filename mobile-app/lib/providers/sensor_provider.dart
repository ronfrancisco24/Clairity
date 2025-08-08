import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/sensor_model.dart';
import '../services/sensor_reading_service.dart'; // You'll create this model

class SensorProvider extends ChangeNotifier {
  //TODO: implement current readings from sensor_reading_service
  //TODO: after accessing current data from sensor_service use SensorDetails from sensor_model.dart\

  final SensorReadingService _service = SensorReadingService();
  SensorDetails? currentData;
  List<SensorDetails> forecastReadingData = [];

  StreamSubscription? _currentDataSubscription;
  StreamSubscription? _forecastDataSubscription;

  void listenToSensor(String sensorId) {
    _currentDataSubscription?.cancel();
    _forecastDataSubscription?.cancel();

    _currentDataSubscription =
        _service.streamLatestReading(sensorId).listen((doc) {
          if (doc.exists) {
            currentData = SensorDetails.fromMap(doc.data());
            notifyListeners();

            // Always listen to forecast from the latest reading
            final latestReadingId = doc.id;
            _forecastDataSubscription?.cancel(); // cancel old forecast Subscription
            _forecastDataSubscription = _service
                .streamForecastReadings(sensorId, latestReadingId)
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
