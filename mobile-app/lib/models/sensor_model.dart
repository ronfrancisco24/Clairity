class SensorDetails {
  final DateTime timestamp;
  final double pm25;
  final double co;
  final double nh3;
  final double h2s;
  final double ch4;
  final double co2;
  final double vocs;
  final double temp;
  final double humidity;

  SensorDetails({
    required this.timestamp,
    required this.pm25,
    required this.co,
    required this.nh3,
    required this.h2s,
    required this.ch4,
    required this.co2,
    required this.vocs,
    required this.temp,
    required this.humidity,
  });
}