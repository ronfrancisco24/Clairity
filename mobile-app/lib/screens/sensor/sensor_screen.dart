import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

// Import all separated widgets
import '../../widgets/sensor/notifications_button.dart';
import '../../widgets/sensor/sensor_card.dart';
import '../../widgets/sensor/circular_indicator.dart';
import '../../widgets/sensor/time_info_tile.dart';
import '../../widgets/sensor/sensor_grid.dart';
import '../../widgets/sensor/sensor_gender_buttons.dart';

// Import the new utility file
import '../../utils/sensor_utils.dart';

class SensorScreen extends StatefulWidget {
  const SensorScreen({super.key});

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  String _selectedGender = 'male'; // State to manage selected gender
  DateTime _selectedDate = DateTime.now(); // State to manage selected date

  // Define all sensor data here, with a 'gender' field for filtering
  final List<SensorCard> _allSensorData = [
    // Male restroom sensor data
    SensorCard(
      gender: 'male',
      title: 'Good',
      subtitle: 'Air Quality',
      color: const Color(0xFF7D9B4B),
    ),
    SensorCard(
      gender: 'male',
      title: 'Low',
      subtitle: 'Dust',
      color: const Color(0xFF425861),
    ),
    SensorCard(
      gender: 'male',
      title: 'High',
      subtitle: 'Ammonia',
      color: const Color(0xFFD26A6A),
    ),
    SensorCard(
      gender: 'male',
      title: 'Safe',
      subtitle: 'CO',
      color: const Color(0xFFF47C2A),
    ),
    SensorCard(
      gender: 'male',
      title: 'Decent',
      subtitle: 'Temperature',
      color: const Color(0xFFF47C2A),
    ),
    SensorCard(
      gender: 'male',
      title: 'Excellent',
      subtitle: 'Humidity',
      color: const Color(0xFF2A9D8F),
    ),

    // Female restroom sensor data
    SensorCard(
      gender: 'female',
      title: 'Very Good',
      subtitle: 'Air Quality',
      color: const Color(0xFF7D9B4B),
    ),
    SensorCard(
      gender: 'female',
      title: 'Moderate',
      subtitle: 'Dust',
      color: const Color(0xFF425861),
    ),
    SensorCard(
      gender: 'female',
      title: 'Low',
      subtitle: 'Ammonia',
      color: const Color(0xFF2A9D8F),
    ),
    SensorCard(
      gender: 'female',
      title: 'Critical',
      subtitle: 'CO',
      color: const Color(0xFF8B0000),
    ),
    SensorCard(
      gender: 'female',
      title: 'Cool',
      subtitle: 'Temperature',
      color: const Color(0xFF425861),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    // Use the utility function to filter data
    final currentSensorData = SensorUtils.getFilteredSensorData(
      _allSensorData,
      _selectedGender,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: ListView(
            children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sensors",
                    style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                  ),
                  NotificationsButton(),
                ],
              ),
              SizedBox(height: 16.h), // Spacing below the header
              // Date Selector
              GestureDetector(
                onTap: () async {
                  // Use the utility function to select date
                  final DateTime? picked = await SensorUtils.selectDate(
                    context,
                    _selectedDate,
                  );
                  if (picked != null && picked != _selectedDate) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey[300]!, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('d MMM yyyy').format(_selectedDate),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Icon(Icons.calendar_today, size: 20.sp, color: Colors.grey[600]),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h), // Spacing after the date selector
              const CircularIndicator(percentage: 75, label: "Good"),
              SizedBox(height: 20.h),
              Text(
                "Lorem ipsum dolor sit amet consectetur. Faucibus mattis volutpat pellentesque et enim lectus sed integer in.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, height: 1.4),
              ),
              SizedBox(height: 24.h),
              GenderButtonWidget(
                selectedGender: _selectedGender,
                onGenderSelected: (gender) {
                  setState(() {
                    _selectedGender = gender;
                  });
                },
              ),
              SizedBox(height: 10.h),
              Divider(
                color: Colors.grey[300],
                thickness: 2,
                height: 0,
                indent: 0,
                endIndent: 0,
              ),
              SizedBox(height: 16.h),
              SensorGridWidget(sensorData: currentSensorData),
              SizedBox(height: 20.h),
              SensorCard(
                title: 'Alerts',
                subtitle: 'Smell too strong – Clean Now!',
                color: Color(0xFF8B0000),
                titleStyle: TextStyle(fontSize: 24.sp, color: Colors.white, fontWeight: FontWeight.bold),
                subtitleStyle: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
              SizedBox(height: 20.h),
              Row(
                children: const [
                  TimeInfoTile(time: "10:30", label: "Last Cleaned", icon: Icons.wb_sunny_outlined),
                  SizedBox(width: 12),
                  TimeInfoTile(time: "2:00", label: "Clean Again By", icon: Icons.dark_mode_outlined),
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
