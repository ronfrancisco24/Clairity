import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SensorCard extends StatelessWidget {
  final String title;
  final String? gender;
  final String subtitle;
  final Color color;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const SensorCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.color,
    this.titleStyle,
    this.subtitleStyle,
    this.gender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ?? TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: subtitleStyle ?? TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
