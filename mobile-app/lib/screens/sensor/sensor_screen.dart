import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../widgets/sensor/notifications/notifications_button.dart';
import '../../widgets/sensor/sensor_card.dart';
import '../../widgets/sensor/circular_indicator.dart';
import '../../widgets/sensor/time_info_tile.dart';
import '../../widgets/sensor/sensor_grid.dart';
import '../../widgets/sensor/sensor_gender_buttons.dart';
import '../../utils/sensor_utils.dart';
import '../../constants.dart' as constants;

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
    const SensorCard(
      gender: 'male',
      title: 'Good',
      subtitle: 'Air Quality',
      color: Color(0xFF7D9B4B),
    ),
    const SensorCard(
      gender: 'male',
      title: 'Low',
      subtitle: 'Dust',
      color: Color(0xFF425861),
    ),
    const SensorCard(
      gender: 'male',
      title: 'High',
      subtitle: 'Ammonia',
      color: Color(0xFFD26A6A),
    ),
    const SensorCard(
      gender: 'male',
      title: 'Safe',
      subtitle: 'CO',
      color: Color(0xFFF47C2A),
    ),
    const SensorCard(
      gender: 'male',
      title: 'Decent',
      subtitle: 'Temperature',
      color: Color(0xFFF47C2A),
    ),
    const SensorCard(
      gender: 'male',
      title: 'Excellent',
      subtitle: 'Humidity',
      color: Color(0xFF2A9D8F),
    ),

    // Female restroom sensor data
    const SensorCard(
      gender: 'female',
      title: 'Very Good',
      subtitle: 'Air Quality',
      color: Color(0xFF7D9B4B),
    ),
    const SensorCard(
      gender: 'female',
      title: 'Moderate',
      subtitle: 'Dust',
      color: Color(0xFF425861),
    ),
    const SensorCard(
      gender: 'female',
      title: 'Low',
      subtitle: 'Ammonia',
      color: Color(0xFF2A9D8F),
    ),
    const SensorCard(
      gender: 'female',
      title: 'Critical',
      subtitle: 'CO',
      color: Color(0xFF8B0000),
    ),
    const SensorCard(
      gender: 'female',
      title: 'Cool',
      subtitle: 'Temperature',
      color: Color(0xFF425861),
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
                    "Sensor",
                    style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                  ),
                  const NotificationsButton(),
                ],
              ),
              SizedBox(height: 16.h), // Spacing below the header
              // Date Selector

              SizedBox(height: 20.h), // Spacing after the date selector
              const CircularIndicator(percentage: 38, label: "Good"),
              SizedBox(height: 20.h),
              Text(
                "Lorem ipsum dolor sit amet consectetur. Faucibus mattis volutpat pellentesque et enim lectus sed integer in.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, height: 1.4),
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
                color: const Color(0xFF8B0000),
                titleStyle: TextStyle(fontSize: 24.sp, color: Colors.white, fontWeight: FontWeight.bold),
                subtitleStyle: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
              SizedBox(height: 20.h),
              const Row(
                children: [
                  TimeInfoTile(time: "10:30", label: "Last Cleaned", icon: Icons.wb_sunny_outlined),
                  SizedBox(width: 12),
                  TimeInfoTile(time: "2:00", label: "Clean Again By", icon: Icons.dark_mode_outlined),
                ],
              ),
              SizedBox(height: constants.bottomOffset.h + constants.navBarHeight.h),
            ],
          ),
        ),
      ),
    );
  }
}
