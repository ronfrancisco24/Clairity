import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeInfoTile extends StatelessWidget {
  final String time;
  final String label;
  final IconData? icon;

  const TimeInfoTile({super.key, required this.time, required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF3E1C3),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            if (icon != null) Icon(icon, size: 20.sp),
            Text(time, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp)),
            SizedBox(height: 4.h),
            Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp)),
          ],
        ),
      ),
    );
  }
}
