import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'alert_tile.dart';

class PastAlertsTab extends StatelessWidget {
  const PastAlertsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.sp),
      children: const [
        AlertTile(date: "May 22", alert: "High Hydrogen Sulfide", status: "Resolved"),
        AlertTile(date: "May 30", alert: "High CO2", status: "Ventilated"),
        AlertTile(date: "May 29", alert: "High Dust/PM2.5", status: "Cleaned"),
      ],
    );
  }
}
