import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../models/sensor_data_model.dart';
import '../../../providers/sensor_provider.dart';
import '../../../utils/history_utils.dart';
import '../cleaner_calendar.dart';
import '../../../constants.dart' as constants;
import 'sensor_chart.dart';
import '../../../services/history_reading_service.dart';
import 'sensor_dropdown.dart';

class SensorDataTab extends StatefulWidget {
  const SensorDataTab({super.key});

  @override
  State<SensorDataTab> createState() => _SensorDataTabState();
}

class _SensorDataTabState extends State<SensorDataTab> {
  // DateTime selectedDate = DateTime.now().toUtc().add(const Duration(hours: 8));
  DateTime selectedDate = DateTime.now();
  final PageController _pageController = PageController(viewportFraction: 0.95);
  late String selectedSensor;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final sensors = Provider.of<SensorProvider>(context, listen: false).sensorIds;
    selectedSensor = sensors.isNotEmpty ? sensors[0] : ""; // initial value
  }

  @override
  Widget build(BuildContext context) {
    final sensorProvider = Provider.of<SensorProvider>(context);
    final sensors = sensorProvider.sensorIds;

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getMonthYearText(selectedDate),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SensorDropdown(
                  list: sensors,
                  value: selectedSensor,
                  onChanged: (newValue) {
                    setState(() {
                      selectedSensor = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
          CalendarWidget(
            // Custom Calendar
            selectedDate: selectedDate,
            onDateSelected: (date) {
              setState(() => selectedDate = date);
            },
          ),
          SizedBox(height: 5.h),
          Expanded(
            // Chart list with snapping effect
            child: StreamBuilder<List<SensorDataModel>>(
                key: ValueKey('$selectedSensor-$selectedDate'),
                stream: streamSensorHistoryData(selectedSensor, selectedDate),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    print('No data');
                  }

                  final filteredSensorDetails = snapshot.data ?? [];

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
                      valueSelector: (s) => s.tvoc,
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

                  return Padding(
                    padding:
                        EdgeInsets.only(bottom: constants.bottomOffset.h + 40),
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
                  );
                }),
          ),
        ],
      ),
    );
  }
}
