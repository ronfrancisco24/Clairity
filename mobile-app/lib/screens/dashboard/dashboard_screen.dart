import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/sensor/notifications_button.dart';
import '../../widgets/dashboard/card_location.dart';
import '../../widgets/dashboard/card_currents.dart';
import '../../widgets/dashboard/card_quality.dart';
import '../../widgets/dashboard/card_status_sensor.dart';
import '../../widgets/dashboard/card_message.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedTimeIndex = 0;
  final List<String> times = ['8:00 am', '9:00 am', '9:30 am', '10:00 am'];

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
                          'Good Morning, John!',
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
                  imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
                  title: 'PGN 1st Floor',
                  subtitle: 'Near Printing Station',
                ),
                SizedBox(height: 16.h),
                // Time Selector
                SizedBox(
                  height: 32.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: times.length,
                    separatorBuilder: (context, index) => SizedBox(width: 12.w),
                    itemBuilder: (context, index) {
                      final selected = selectedTimeIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTimeIndex = index;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: selected ? Colors.black : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: selected ? Colors.black :  Colors.black,
                            ),
                          ),
                          child: Text(
                            times[index],
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.black,
                              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
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
                        value: 120,
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
                  message: 'Air quality in CR2 is unhealthy.\nRecommend airing out the room or limiting occupancy.',
                ),
                SizedBox(height: 16.h),
                // Pollutant Cards
                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth > 400 ? 4 : 2;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1.4,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return const CardStatusSensor(
                          value: 12,
                          maxValue: 120,
                          label: 'PM2.5',
                          progress: 0.1,
                        );
                      },
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
