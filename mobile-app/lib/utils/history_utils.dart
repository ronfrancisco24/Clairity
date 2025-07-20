import 'dart:math';

import 'package:flutter/material.dart';
import '../models/record_timestampped_model.dart';
import '../models/sensor_model.dart';

List<T> filterRecordsByDate<T extends TimestampedRecord>(List<T> records, DateTime selectedDate) {
  return records.where((record) {
    final date = record.timestamp;
    return date.year == selectedDate.year &&
        date.month == selectedDate.month &&
        date.day == selectedDate.day;
  }).toList();
}

// Returns a formatted string of the selected date.
String formatSelectedDate(DateTime selectedDate) {
  return '${_weekdayName(selectedDate.weekday)}, ${_twoDigits(selectedDate.day)} ${_monthName(selectedDate.month)} ${selectedDate.year}';
}

// Returns weekday name from integer.
String _weekdayName(int weekday) {
  const weekdays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];
  return weekdays[weekday - 1];
}

// Returns month name from integer.
String _monthName(int month) {
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  return months[month - 1];
}

// Pads single digit numbers with a leading zero.
String _twoDigits(int n) => n.toString().padLeft(2, '0');

// Filters the list of sensor details by the selected date.
List<SensorDetails> filterSensorDetailsByDate(List<SensorDetails> samples, DateTime selectedDate) {
  return samples.where((sensorDetail) {
    return sensorDetail.timestamp.year == selectedDate.year &&
        sensorDetail.timestamp.month == selectedDate.month &&
        sensorDetail.timestamp.day == selectedDate.day;
  }).toList();
}

List<T> sortByDate<T>(List<T> items, DateTime Function(T) getDate, {bool descending = true}) {
  items.sort((a, b) {
    final dateA = getDate(a);
    final dateB = getDate(b);
    return descending ? dateB.compareTo(dateA) : dateA.compareTo(dateB);
  });
  return items;
}

Color getRandomIconColor() {
  final List<Color> colorOptions = [
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.purple,
    Colors.blue,
    Colors.teal,
    Colors.brown,
    Colors.pink,
    Colors.indigo,
  ];

  final random = Random();
  return colorOptions[random.nextInt(colorOptions.length)];
}