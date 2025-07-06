import 'package:flutter/material.dart';
import '../widgets/sensor/sensor_card.dart'; // Import SensorCard as it's used here

class SensorUtils {
  static List<SensorCard> getFilteredSensorData(
      List<SensorCard> allData, String selectedGender) {
    return allData.where((card) => card.gender == selectedGender).toList();
  }

  static Future<DateTime?> selectDate(
      BuildContext context, DateTime initialDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blueGrey, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blueGrey, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    return picked;
  }
}
