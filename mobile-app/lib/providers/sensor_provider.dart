import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/sensor_model_details.dart';
import '../services/sensor_reading_service.dart';

class SensorProvider extends ChangeNotifier {
  final _service = FirebaseFirestore.instance;
  SensorDetails? _currentData;
  List<SensorDetails> _forecastReadingData = [];
  final List<String> _sensorIds = [];
  String? _sensorId;


  SensorDetails? get currentData => _currentData;
  List<SensorDetails> get forecastReadingData => _forecastReadingData;
  List<String> get sensorIds => _sensorIds;
  String? get sensorId => _sensorId;

  void setCurrentData(SensorDetails data) {
    _currentData = data;
    notifyListeners();
  }

  void setForecastData(List<SensorDetails> forecasts) {
    _forecastReadingData = forecasts;
    notifyListeners();
  }

  void setSensorId(String sensorId){
    _sensorId = sensorId;
    notifyListeners();
  }

  Future<void> loadSensorIds() async {
    final ids = await SensorReadingService().fetchAllSensorIds();
    _sensorIds.clear();
    _sensorIds.addAll(ids);
    notifyListeners();
  }

}