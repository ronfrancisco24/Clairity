import 'package:shared_preferences/shared_preferences.dart';

//TODO: include background checks for app

// save values locally after sending a notification
Future<void> saveLastNotifiedValue(String label, double value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('last_$label', value);
}


Future<void> saveLastNotifiedAqi(double value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('last_aqi', value);
}

// get last notified values from local storage

Future<double?> getLastNotifiedValue(String label) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getDouble('last_$label');
}

Future<double?> getLastNotifiedAqi() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getDouble('last_aqi');
}