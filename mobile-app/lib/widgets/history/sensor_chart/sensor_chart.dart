import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/sensor_data_model.dart';
import 'sensor_chart_header.dart';
import 'sensor_line_chart.dart';

class SensorChart extends StatelessWidget {
  final String label;
  final Color color;
  final List<SensorDataModel> data;
  final double Function(SensorDataModel) valueSelector;

  const SensorChart({
    super.key,
    required this.label,
    required this.color,
    required this.data,
    required this.valueSelector,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SensorChartHeader(label: label),
          SizedBox(height: 20.h),
          SizedBox(
            height: 200.h,
            child: SensorLineChart(
              label: label,
              color: color,
              data: data,
              valueSelector: valueSelector,
            ),
          ),
        ],
      ),
    );
  }
}
