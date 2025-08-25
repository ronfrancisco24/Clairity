import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/header.dart';
import '../../widgets/history/history_tab_selector.dart';
import '../../widgets/history/past_alerts/past_alerts_tab.dart';
import '../../widgets/history/cleaning_records/cleaning_records_tab.dart';
import '../../widgets/history/sensor_chart/sensor_data_tab.dart';

//TODO: change sensor data pollutants to use thresholds

class HistoryScreen extends StatefulWidget {
  final int initialIndex;

  const HistoryScreen({super.key, this.initialIndex = 1});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late int selectedIndex;

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
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: const DashboardHeader(title: 'History', hasDate: false)
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