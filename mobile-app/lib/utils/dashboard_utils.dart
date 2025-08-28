import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../models/sensor_model_details.dart';
import '../models/sensor_model_details.dart';

List<String> generateTimeSlots() {
  final now = DateTime.now().toUtc().add(const Duration(hours: 8));
  final List<String> times = [];

  for (int i = 0; i <= 4; i++) {
    final time = now.add(Duration(minutes: i * 30));
    times.add(DateFormat.jm().format(time));
  }

  return times;
}

IconData getTimeIcon(DateTime? time) {
  if (time!.hour >= 6 && time.hour <= 18) {
    return Icons.wb_sunny_outlined;
  } else {
    return Icons.dark_mode_outlined;
  }
}

getFormattedTime(DateTime time) {
  return DateFormat('h:mm a').format(time);
}

getFormattedMonth(DateTime time) {
  return DateFormat('MMM d').format(time);
}

DateTime? getNextCleaningTime(
    SensorDetails? current,
    SensorDetails? forecast,
    ) {
  final now = DateTime.now().toUtc().add(const Duration(hours: 8));

  // 1. If current reading is risky, clean now
  if (current != null &&
      ['At Risk', 'Unhealthy', 'Hazardous'].contains(current.aqiCategory)) {
    return now;
  }

  // 2. If the forecast is risky and in the future, schedule cleaning at that time
  if (forecast != null &&
      ['At Risk', 'Unhealthy', 'Hazardous'].contains(forecast.aqiCategory)) {
    if (forecast.timestamp.isAfter(now)) {
      return forecast.timestamp;
    } else {
      // forecast is risky but in the past → clean now
      return now;
    }
  }

  // 3. Otherwise, no cleaning needed
  return null;
}



double getProgress(double value, {required double max}) {
  if (max == 0) return 0.0;
  return (value / max).clamp(0.0, 1.0);
}

const Map<String, double> pollutantMaxValues = {
  'PM2.5': 500.4,
  'TVOC': 5500.0,
  'CO': 50.4,
  'CO₂': 18000.0,
  'NH₃': 50.0,
  'CH₄': 19.9,
  'H₂S': 60.0,
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
    case 'Unhealthy':
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

const Map<String, String> aqiMessages = {
  'Good': 'Air quality is good. Enjoy your day!',
  'Moderate': 'Air quality is acceptable, but sensitive individuals should be cautious.',
  'At Risk': 'Air quality may affect vulnerable groups. Consider limiting strenuous activity.',
  'Unhealthy': 'Air quality is unhealthy. Recommend limiting occupancy and ventilating if possible.',
  'Hazardous': 'Air quality is hazardous. Strongly advise avoiding exposure and ensuring proper ventilation.',
};

String getAqiMessage(String category) {
  return aqiMessages[category] ?? 'Air quality data unavailable.';
}

List<Map<String, dynamic>> getCurrentData(SensorDetails data, {String? forecastId}) {
  return [
    {
      'label': 'PM2.5',
      'value': data.pm25,
      'progress': getProgress(data.pm25, max: pollutantMaxValues['PM2.5']!),
    },
    {
      'label': 'H₂S',
      'value': data.h2s,
      'progress': getProgress(data.h2s, max: pollutantMaxValues['H₂S']!),
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
      'label': 'TVOC',
      'value': data.tvoc,
      'progress': getProgress(data.tvoc, max: pollutantMaxValues['TVOC']!),
    },
  ];
}


String getAlertLabel(int warningLevel) {
  switch (warningLevel) {
    case 1:
      return "Low Gas Levels";
    case 2:
      return "Moderate Gas Levels Detected";
    case 3:
      return "High Gas Levels Detected";
    case 4:
      return "Hazardous Gas Levels!";
    default:
      return "Unknown";
  }
}

Map<String, double> getNormalizedReadings(SensorDetails data){
  return {
    'PM2.5': getProgress(data.pm25, max: pollutantMaxValues['PM2.5']!),
    'TVOC': getProgress(data.tvoc, max: pollutantMaxValues['TVOC']!),
    'CO': getProgress(data.co, max: pollutantMaxValues['CO']!),
    'CO₂': getProgress(data.co2, max: pollutantMaxValues['CO₂']!),
    'NH₃': getProgress(data.nh3, max: pollutantMaxValues['NH₃']!),
    'CH₄': getProgress(data.ch4, max: pollutantMaxValues['CH₄']!),
    'H₂S': getProgress(data.h2s, max: pollutantMaxValues['H₂S']!),
  };
}

MapEntry<String, double> getHighestPollutant(SensorDetails data) {
  final normalized = getNormalizedReadings(data);

  // find the entry with max progress
  final highest = normalized.entries.reduce(
        (a, b) => a.value >= b.value ? a : b,
  );

  return highest;
}

String getPollutantLevel(double value) {
  if (value < 0.3) return "Good";
  if (value < 0.6) return "Moderate";
  if (value < 0.8) return "Unhealthy";
  return "Hazardous";
}





