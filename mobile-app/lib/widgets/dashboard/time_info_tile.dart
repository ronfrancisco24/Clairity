import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeInfoTile extends StatelessWidget {
  final String time;
  final String label;
  final String date;
  final IconData? icon;
  final Color? iconColor;

  const TimeInfoTile(
      {super.key,
      required this.time,
      required this.label,
      required this.date,
      this.icon,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 20.sp,
                color: Colors.white,
              ),
            SizedBox(height: 4.h),
            Text(
              date,
              style: TextStyle(fontSize: 13.sp, color: Colors.white),
            ),
            Text(time,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: Colors.white)),
            SizedBox(height: 4.h),
            Text(label,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.sp, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
