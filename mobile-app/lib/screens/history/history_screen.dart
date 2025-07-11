import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/history/gender_dropdown.dart';
import '../../widgets/history/past_alerts_tab.dart';
import '../../widgets/history/cleaning_records_tab.dart';
import '../../widgets/history/sensor_data_tab.dart';
import '../../widgets/sensor/notifications_button.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String selectedGender = 'Male';
  int selectedIndex = 0;

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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "History ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.sp,
                      ),
                    ),
                    GenderDropdownIcon(
                      selectedGender: selectedGender,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedGender = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
                const NotificationsButton(),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_tabTitles.length, (index) {
                bool isSelected = selectedIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedIndex = index),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color:
                        isSelected ? Colors.black87 : Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                            color: Colors.black87
                        )
                      ),
                      child: Center(
                        child: Text(
                          _tabTitles[index],
                          style: TextStyle(
                            color:
                            isSelected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: _tabs[selectedIndex],
          ),
        ],
      ),
    );
  }
}