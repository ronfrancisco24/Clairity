import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'sensor_chart.dart';

class SensorDataTab extends StatelessWidget {
  const SensorDataTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.sp),
      child: Column(
        children: [
          SensorChart(
              label: "PM2.5",
              color: Colors.blue,
              values: [10, 12, 15, 20, 22, 30, 50]),
          SizedBox(height: 20.h),
          SensorChart(
              label: "CO2",
              color: Colors.purple,
              values: [1500, 1600, 1700, 1900, 2000, 2200, 2400]),
          SizedBox(height: 20.h),
          SensorChart(
              label: "Close Deals",
              color: Colors.cyan,
              values: [1000, 1200, 1400, 1800, 2100, 2300, 3000]),
        ],
      ),
    );
  }
}
