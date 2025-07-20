import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/sensor_model.dart';
import '../../../utils/history_utils.dart';
import '../cleaner_calendar.dart';
import '../../../constants.dart' as constants;
import 'sensor_chart.dart';

class SensorDataTab extends StatefulWidget {
  const SensorDataTab({super.key});

  @override
  State<SensorDataTab> createState() => _SensorDataTabState();
}

class _SensorDataTabState extends State<SensorDataTab> {
  DateTime selectedDate = DateTime.now();
  final PageController _pageController = PageController(viewportFraction: 0.95);

  final List<SensorDetails> samples = [
    //For now, Samples are per hour.
    SensorDetails(timestamp: DateTime(2025, 7, 18, 0, 0), pm25: 15.2, co: 2.1, nh3: 3.5, h2s: 1.2, ch4: 120, co2: 800, vocs: 320, temp: 23.2, humidity: 78),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 1, 0), pm25: 12.8, co: 1.8, nh3: 2.9, h2s: 0.9, ch4: 110, co2: 750, vocs: 280, temp: 22.8, humidity: 80),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 2, 0), pm25: 10.5, co: 1.5, nh3: 2.3, h2s: 0.7, ch4: 95, co2: 700, vocs: 240, temp: 22.5, humidity: 82),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 3, 0), pm25: 9.8, co: 1.3, nh3: 2.1, h2s: 0.6, ch4: 85, co2: 680, vocs: 220, temp: 22.2, humidity: 84),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 4, 0), pm25: 11.2, co: 1.6, nh3: 2.4, h2s: 0.8, ch4: 100, co2: 720, vocs: 260, temp: 22.8, humidity: 82),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 5, 0), pm25: 18.5, co: 2.8, nh3: 4.2, h2s: 1.5, ch4: 150, co2: 950, vocs: 420, temp: 24.1, humidity: 78),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 6, 0), pm25: 32.7, co: 4.5, nh3: 7.8, h2s: 2.8, ch4: 220, co2: 1450, vocs: 650, temp: 25.5, humidity: 72),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 7, 0), pm25: 48.3, co: 6.2, nh3: 11.5, h2s: 4.1, ch4: 310, co2: 2100, vocs: 890, temp: 26.8, humidity: 68),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 8, 0), pm25: 65.9, co: 8.7, nh3: 15.8, h2s: 5.6, ch4: 420, co2: 2800, vocs: 1200, temp: 28.2, humidity: 64),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 9, 0), pm25: 58.4, co: 7.9, nh3: 13.2, h2s: 4.8, ch4: 380, co2: 2500, vocs: 1050, temp: 29.5, humidity: 60),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 10, 0), pm25: 42.1, co: 5.8, nh3: 9.5, h2s: 3.4, ch4: 280, co2: 1900, vocs: 750, temp: 31.2, humidity: 58),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 11, 0), pm25: 38.7, co: 5.2, nh3: 8.1, h2s: 2.9, ch4: 240, co2: 1650, vocs: 680, temp: 32.8, humidity: 55),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 12, 0), pm25: 45.2, co: 6.1, nh3: 9.8, h2s: 3.5, ch4: 290, co2: 1950, vocs: 820, temp: 34.1, humidity: 52),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 13, 0), pm25: 52.8, co: 7.3, nh3: 12.4, h2s: 4.3, ch4: 350, co2: 2300, vocs: 980, temp: 35.5, humidity: 49),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 14, 0), pm25: 61.5, co: 8.6, nh3: 15.1, h2s: 5.2, ch4: 410, co2: 2700, vocs: 1150, temp: 36.8, humidity: 46),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 15, 0), pm25: 58.9, co: 8.1, nh3: 14.2, h2s: 4.9, ch4: 390, co2: 2550, vocs: 1080, temp: 37.2, humidity: 44),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 16, 0), pm25: 67.3, co: 9.2, nh3: 16.8, h2s: 5.8, ch4: 450, co2: 2950, vocs: 1280, temp: 36.9, humidity: 46),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 17, 0), pm25: 78.6, co: 10.8, nh3: 19.5, h2s: 6.9, ch4: 520, co2: 3400, vocs: 1480, temp: 35.8, humidity: 49),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 18, 0), pm25: 89.2, co: 12.5, nh3: 22.8, h2s: 8.1, ch4: 610, co2: 4100, vocs: 1750, temp: 34.2, humidity: 52),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 19, 0), pm25: 95.7, co: 13.8, nh3: 25.2, h2s: 8.9, ch4: 680, co2: 4600, vocs: 1950, temp: 32.5, humidity: 56),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 20, 0), pm25: 82.4, co: 11.6, nh3: 20.8, h2s: 7.4, ch4: 580, co2: 3800, vocs: 1650, temp: 30.8, humidity: 60),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 21, 0), pm25: 68.1, co: 9.4, nh3: 16.2, h2s: 5.8, ch4: 480, co2: 3200, vocs: 1350, temp: 29.2, humidity: 64),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 22, 0), pm25: 52.3, co: 7.2, nh3: 12.1, h2s: 4.3, ch4: 370, co2: 2600, vocs: 1050, temp: 27.8, humidity: 68),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 23, 0), pm25: 38.9, co: 5.4, nh3: 8.5, h2s: 3.0, ch4: 280, co2: 1900, vocs: 750, temp: 26.2, humidity: 72),
    SensorDetails(timestamp: DateTime(2025, 7, 18, 23, 59), pm25: 38.9, co: 5.4, nh3: 8.5, h2s: 3.0, ch4: 280, co2: 1900, vocs: 750, temp: 26.2, humidity: 72),
  ];

  List<SensorDetails> get filteredSensorDetails {
    return filterSensorDetailsByDate(samples,selectedDate);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> chartWidgets = [
      SensorChart(
        label: "PM2.5",
        color: Colors.blue,
        data: filteredSensorDetails,
        valueSelector: (s) => s.pm25,
      ),
      SensorChart(
        label: "CO",
        color: Colors.purple,
        data: filteredSensorDetails,
        valueSelector: (s) => s.co,
      ),
      SensorChart(
        label: "NH3",
        color: Colors.cyan,
        data: filteredSensorDetails,
        valueSelector: (s) => s.nh3,
      ),
      SensorChart(
        label: "H2S",
        color: Colors.cyan,
        data: filteredSensorDetails,
        valueSelector: (s) => s.h2s,
      ),
      SensorChart(
        label: "CH4",
        color: Colors.cyan,
        data: filteredSensorDetails,
        valueSelector: (s) => s.ch4,
      ),
      SensorChart(
        label: "CO2",
        color: Colors.cyan,
        data: filteredSensorDetails,
        valueSelector: (s) => s.co2,
      ),
      SensorChart(
        label: "TVOC",
        color: Colors.cyan,
        data: filteredSensorDetails,
        valueSelector: (s) => s.vocs,
      ),
      SensorChart(
        label: "Temperature",
        color: Colors.orange,
        data: filteredSensorDetails,
        valueSelector: (s) => s.temp,
      ),
      SensorChart(
        label: "Humidity",
        color: Colors.blue,
        data: filteredSensorDetails,
        valueSelector: (s) => s.humidity,
      ),
    ];

    return Column(
      children: [
        CalendarWidget( // Custom Calendar
          selectedDate: selectedDate,
          onDateSelected: (date) {
            setState(() => selectedDate = date);
          },
        ),
        SizedBox(height: 5.h),
        Expanded( // Chart list with snapping effect
          child: Padding(
            padding: EdgeInsets.only(bottom: constants.bottomOffset.h + 40),
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: chartWidgets.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: chartWidgets[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}