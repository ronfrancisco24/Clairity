import '../models/sensor_data_model.dart';
import '../models/forecasted_sensor_data_model.dart';

abstract class AqiBase {
  DateTime get timestamp;
  double? get aqi;
  String? get aqiCategory;
}
