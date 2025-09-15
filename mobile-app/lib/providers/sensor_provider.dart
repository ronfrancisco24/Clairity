import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/forecasted_sensor_data_model.dart';
import '../models/sensor_data_model.dart';
import '../services/sensor_reading_service.dart';

class SensorProvider extends ChangeNotifier {
  SensorDataModel? _currentData;
  SensorDataModel? _forecastReadingData;
  ForecastedDataModel? _predictedData;
  final List<String> _sensorIds = [];
  String? _sensorId;


  SensorDataModel? get currentData => _currentData;
  SensorDataModel? get forecastReadingData => _forecastReadingData;
  ForecastedDataModel? get predictedData => _predictedData;
  List<String> get sensorIds => _sensorIds;
  String? get sensorId => _sensorId;

  void setPredictedData(ForecastedDataModel prediction){
    _predictedData = prediction;
    notifyListeners();
  }

  void setCurrentData(SensorDataModel data) {
    _currentData = data;
    notifyListeners();
  }

  void setForecastData(SensorDataModel forecast) {
    _forecastReadingData = forecast;
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