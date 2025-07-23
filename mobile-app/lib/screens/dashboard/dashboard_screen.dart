import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/sensor/notifications_button.dart';
import '../../widgets/dashboard/card_location.dart';
import '../../widgets/dashboard/card_currents.dart';
import '../../widgets/dashboard/card_quality.dart';
import '../../widgets/dashboard/pollutant_grid.dart';
import '../../widgets/dashboard/time_selector.dart';
import '../../widgets/dashboard/card_message.dart';
import '../../utils/dashboard_time_utils.dart';
import 'dart:math';

// TODO: modularize code here more.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedTimeIndex = 0;
  final List<String> times = generateTimeSlots();

  // used for the different values in time.
  List<List<Map<String, dynamic>>> pollutantData = List.generate(
    5,
    (index) => [
      {
        'label': 'PM2.5',
        'value': 12 + index * 5,
        'progress': min(0.3 + index * 0.2, 1.0)
      },
      {
        'label': 'VOC',
        'value': 20 + index * 4,
        'progress': min(0.3 + index * 0.1, 1.0),
      },
      {
        'label': 'CO',
        'value': 20 + index * 4,
        'progress': min(0.4 + index * 0.1, 1.0),
      },
      {
        'label': 'CO₂',
        'value': 20 + index * 4,
        'progress': min(0.4 + index * 0.1, 1.0),
      },
      {
        'label': 'NH₃',
        'value': 20 + index * 4,
        'progress': min(0.2 + index * 0.15, 1.0),
      },
      {
        'label': 'CH₄',
        'value': 20 + index * 4,
        'progress': min(0.2 + index * 0.15, 1.0),
      },
      {
        'label': 'H₂S',
        'value': 20 + index * 4,
        'progress': min(0.2 + index * 0.15, 1.0),
      },
    ],
  );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w), // Match SensorScreen margins
            child: Column(
              children: [
                // Header
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning, User!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Monday, June 1',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    NotificationsButton(),
                  ],
                ),
                SizedBox(height: 16.h),
                // Location Card
                const CardLocation(
                  imageUrl:
                      'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
                  title: 'PGN 1st Floor',
                  subtitle: 'Near Printing Station',
                ),
                SizedBox(height: 16.h),
                // Time Selector
                SizedBox(
                  height: 32.h, // Ensure it fits the ListView
                  child: TimeSelector(
                    times: times,
                    selectedIndex: selectedTimeIndex,
                    onSelected: (index) {
                      setState(() {
                        selectedTimeIndex = index;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                // Air Quality & Trend Cards
                Row(
                  children: [
                    // Currents Card
                    const Expanded(
                      child: CardCurrents(
                        value: 80,
                        low: 52,
                        high: 89,
                        status: 'Moderate',
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Quality Card
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CardQuality(
                            onTap: () {
                              // TODO: Navigate to sensor screen
                            },
                            trendLabel: 'Air Quality Trend',
                            trendValue: 'Ammonia',
                            trendLevel: 'Moderate',
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // Warning
                CardMessage(
                  message:
                      'Air quality in CR2 is unhealthy.\nRecommend airing out the room or limiting occupancy.',
                ),
                SizedBox(height: 16.h),
                // Pollutant Cards
                LayoutBuilder(
                  builder: (context, constraints) {
                    return PollutantGrid( //TODO: use state management tool to keep data consistent
                      pollutantList: pollutantData[selectedTimeIndex],
                    );
                  },
                ),
                SizedBox(height: 42.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
