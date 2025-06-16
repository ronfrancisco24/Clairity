import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularIndicator extends StatelessWidget {
  final int percentage;
  final String label;

  const CircularIndicator({super.key, required this.percentage, required this.label});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 80.r,
      lineWidth: 16.w,
      percent: percentage / 100,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$percentage%", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.sp)),
          Text(label, style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
        ],
      ),
      progressColor: const Color(0xFFB9D438),
      backgroundColor: const Color(0xFFEAEAEA),
      circularStrokeCap: CircularStrokeCap.round,
      animation: true,
    );
  }
}
