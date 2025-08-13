import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/history/history_tab_selector.dart';
import '../../widgets/history/past_alerts/past_alerts_tab.dart';
import '../../widgets/history/cleaning_records/cleaning_records_tab.dart';
import '../../widgets/history/sensor_chart/sensor_data_tab.dart';
import '../../widgets/sensor/notifications/notifications_button.dart';

//TODO: Make the selected gender filter the data

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int selectedIndex = 1;

  final List<String> _tabTitles = [
    "Past Alerts",
    "Cleaning Records",
    "Sensor Data",
  ];

  final List<Widget> _tabs = const [
    PastAlertsTab(),
    CleaningRecordsTab(),
    SensorDataTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "History ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.sp,
                    color: Colors.black87,
                  ),
                ),
                const NotificationsButton(),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Color(0x00F9FAFC),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            // Custom Tab Bar
            HistoryTabSelector(
              selectedIndex: selectedIndex,
              tabTitles: _tabTitles,
              onTabSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
            SizedBox(height: 20.h),
            // Content Area
            Expanded(
              child: _tabs[selectedIndex],
            ),
          ],
        ),
      ),
    );
  }
}