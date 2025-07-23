import 'package:intl/intl.dart';

List<String> generateTimeSlots() {
  final now = DateTime.now();
  final List<String> times = [];

  for (int i = 0; i <= 4; i++) {
    final time = now.add(Duration(minutes: i * 30));
    times.add(DateFormat.jm().format(time));
  }

  return times;
}
