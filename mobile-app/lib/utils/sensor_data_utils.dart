import '../models/sensor_model_details.dart';

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

const Map<String, int> aqiMaxValues = {
  'Good': 50,
  'Moderate': 100,
  'SensitiveUnhealthy': 150, // your shortened term
  'Unhealthy': 200,
  'VeryUnhealthy': 300,
  'Hazardous': 500,
};

String getAqiCategory(int aqi) {
  if (aqi <= 50) return 'Good';
  if (aqi <= 100) return 'Moderate';
  if (aqi <= 150) return 'At Risk';
  if (aqi <= 200) return 'Unhealthy';
  return 'Hazardous';
}

int getAqiWarningLevel(String category) {
  switch (category) {
    case 'Good':
      return 1;
    case 'Moderate':
      return 2;
    case 'At Risk':
      return 3;
    case 'Hazardous':
      return 4;
    default:
      return 0; // Safe
  }
}

List<Map<String, dynamic>> currentData(SensorDetails data) {
  return [
    {
      'label': 'PM2.5',
      'value': data.pm25,
      'progress': getProgress(data.pm25, max: pollutantMaxValues['PM2.5']!),
    },
    {
      'label': 'VOC',
      'value': data.tvoc,
      'progress': getProgress(data.tvoc, max: pollutantMaxValues['VOC']!),
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


