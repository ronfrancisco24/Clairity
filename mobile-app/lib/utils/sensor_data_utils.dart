import '../models/sensor_model.dart';

double getProgress(double value, {required double max}) {
  if (max == 0) return 0.0;
  return (value / max).clamp(0.0, 1.0);
}

const Map<String, double> pollutantMaxValues = {
  'PM2.5': 100.0,
  'VOC': 600.0,
  'CO': 9.0,
  'CO₂': 1000.0,
  'NH₃': 50.0,
  'CH₄': 1000.0,
  'H₂S': 10.0,
};

List<Map<String, dynamic>> currentData(SensorDetails data) {
  return [
    {
      'label': 'PM2.5',
      'value': data.pm25,
      'progress': getProgress(data.pm25, max: pollutantMaxValues['PM2.5']!),
    },
    {
      'label': 'VOC',
      'value': data.vocs,
      'progress': getProgress(data.vocs, max: pollutantMaxValues['VOC']!),
    },
    {
      'label': 'CO',
      'value': data.co,
      'progress': getProgress(data.co, max: pollutantMaxValues['CO']!),
    },
    {
      'label': 'CO₂',
      'value': data.co2,
      'progress': getProgress(data.co2, max: pollutantMaxValues['CO₂']!),
    },
    {
      'label': 'NH₃',
      'value': data.nh3,
      'progress': getProgress(data.nh3, max: pollutantMaxValues['NH₃']!),
    },
    {
      'label': 'CH₄',
      'value': data.ch4,
      'progress': getProgress(data.ch4, max: pollutantMaxValues['CH₄']!),
    },
    {
      'label': 'H₂S',
      'value': data.h2s,
      'progress': getProgress(data.h2s, max: pollutantMaxValues['H₂S']!),
    },
  ];
}

