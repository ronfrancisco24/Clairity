import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/history_utils.dart';
import '../../../models/alert_model.dart';
import 'alert_tile.dart';
import '../cleaner_calendar.dart';
import '../../../constants.dart' as constants;

class PastAlertsTab extends StatefulWidget {
  const PastAlertsTab({super.key});

  @override
  State<PastAlertsTab> createState() => _PastAlertsTabState();
}

class _PastAlertsTabState extends State<PastAlertsTab> {
  DateTime selectedDate = DateTime.now();

  // Dummy AlertLog model records
  final List<AlertLog> alertRecords = [
    AlertLog(
      alertId: 1,
      restroomId: 101,
      description: 0.95,
      level: 2,
      timestamp: DateTime(2025, 7, 14, 7, 34),
    ),
    AlertLog(
      alertId: 2,
      restroomId: 101,
      description: 0.45,
      level: 1,
      timestamp: DateTime(2025, 7, 14, 11, 33),
    ),
    AlertLog(
      alertId: 3,
      restroomId: 101,
      description: 1.15,
      level: 2,
      timestamp: DateTime(2025, 7, 14, 14, 21),
    ),
    AlertLog(
      alertId: 4,
      restroomId: 101,
      description: 1.30,
      level: 2,
      timestamp: DateTime(2025, 7, 15, 3, 33),
    ),
    AlertLog(
      alertId: 5,
      restroomId: 101,
      description: 0.55,
      level: 1,
      timestamp: DateTime(2025, 7, 15, 7, 12),
    ),
  ];

  List<AlertLog> get filteredRecords {
    return filterRecordsByDate(alertRecords, selectedDate);
  }

  String get formattedDate {
    return formatSelectedDate(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: Column(
        children: [
          CalendarWidget(
            selectedDate: selectedDate,
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            },
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time, size: 16.sp, color: Colors.white),
                SizedBox(width: 8.w),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: filteredRecords.isEmpty
                ? Padding(
              padding: const EdgeInsets.only(bottom: 130),
              child: Center(
                child: Text(
                  "No alerts for this day.",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            )
                : SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.only(bottom: constants.bottomOffset.h + 100),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: filteredRecords.length,
                  itemBuilder: (context, index) {
                    final alert = filteredRecords[index];
                    return AlertTile(
                      date: alert.timestamp,
                      alert: getAlertLabel(alert.description), // Optional: map to readable string
                      status: alert.level == 1 ? "In Progress" : "Resolved",
                      level: alert.level,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // TODO: Need to include AQI and specific pollutant
  String getAlertLabel(double value) {
    if (value >= 1.0) return "High Gas Levels";
    if (value >= 0.5) return "Moderate Gas Levels";
    return "Low Gas Levels";
  }
}
