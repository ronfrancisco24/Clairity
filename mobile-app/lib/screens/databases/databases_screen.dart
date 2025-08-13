import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/databases/cleaning_records_database/records_database_tab.dart';
import '../../widgets/databases/database_tab_selector.dart';
import '../../widgets/history/past_alerts/past_alerts_tab.dart';
import '../../widgets/history/sensor_chart/sensor_data_tab.dart';
import '../../widgets/sensor/notifications/notifications_button.dart';
import '../../widgets/databases/user_data/user_data_tab.dart';

class DatabasesScreen extends StatefulWidget {
  const DatabasesScreen({super.key});

  @override
  State<DatabasesScreen> createState() => _DatabasesScreenState();
}

class _DatabasesScreenState extends State<DatabasesScreen> {
  String selectedGender = 'Male';
  int selectedIndex = 1;

  final List<String> _tabTitles = [
    "Past Alerts",
    "Cleaning Records",
    "Sensor Data",
    "User",
    // Add Prediction Logs
  ];

  final List<Widget> _tabs = const [
    PastAlertsTab(),
    CleaningRecordsDatabaseTab(),
    SensorDataTab(),
    UserDataTab(),
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
                  "Databases",
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
            DatabaseTabSelector(
              selectedIndex: selectedIndex,
              tabTitles: _tabTitles,
              onTabSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: _tabs[selectedIndex],
            ),
          ],
        ),
      ),
    );
  }
}