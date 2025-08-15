import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/sensor_model_details.dart';
import '../../utils/sensor_data_utils.dart';
import 'package:provider/provider.dart';
import '../../widgets/sensor/notifications/notifications_button.dart';
import '../../widgets/dashboard/card_location.dart';
import '../../widgets/dashboard/card_currents.dart';
import '../../widgets/dashboard/card_quality.dart';
import '../../widgets/dashboard/pollutant_grid.dart';
import '../../widgets/dashboard/time_selector.dart';
import '../../widgets/dashboard/card_message.dart';
import '../../utils/dashboard_time_utils.dart';
import '../../providers/sensor_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/sensor_reading_service.dart';
import '../../constants.dart' as constants;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedTimeIndex = 0;
  final List<String> times = generateTimeSlots();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final sensorProvider = context.watch<SensorProvider>();
    final current = sensorProvider.currentData;
    final forecastList = sensorProvider.forecastReadingData;
    final readingId = sensorProvider.readingId;

    final firstName =
        (userProvider.user?.firstName ?? 'No name').toString();

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning, $firstName!',
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
                    Expanded(
                      child: Consumer<SensorProvider>(
                        builder: (context, provider, _) {
                          SensorDetails? selectedReading;
                          if (selectedTimeIndex == 0) {
                            selectedReading = current;
                          } else if (selectedTimeIndex - 1 <
                              forecastList.length) {
                            selectedReading =
                                forecastList[selectedTimeIndex - 1];
                          }

                          // You can adjust how you calculate these
                          final value = (selectedReading?.aqi ?? 0);
                          final low = 23.0;
                          final high = 100.0;
                          final status =
                              selectedReading?.aqiCategory ?? 'Unknown';

                          return CardCurrents(
                            value: value, // If CardCurrents needs int
                            low: low,
                            high: high,
                            status: status,
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Quality Card
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CardQuality(
                            onTap: () async {
                              // TODO: show highest pollutant,
                              // fir testing
                              await SensorReadingService()
                                  .generateRawTestData(
                                      'YDTdkdd2dSFsw6dtyvjd');
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
                //TODO: show recommendation based on pollutant values.
                //TODO: base on the current selected index.
                CardMessage(
                  message:
                      'Air quality in NH3 is unhealthy.\nRecommend airing out the room or limiting occupancy.',
                ),
                SizedBox(height: 16.h),
                // Pollutant Cards

                Consumer<SensorProvider>(builder: (context, provider, _) {
                  SensorDetails? selectedReading;
                  if (selectedTimeIndex == 0) {
                    selectedReading = current;
                  } else if (selectedTimeIndex - 1 < forecastList.length) {
                    selectedReading = forecastList[selectedTimeIndex - 1];
                  }

                  final List<Map<String, dynamic>> pollutants =
                      selectedReading != null
                          ? currentData(selectedReading)
                          : [];

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return PollutantGrid(
                        pollutantList: pollutants, // show placeholder data
                      );
                    },
                  );
                }),
                SizedBox(height: constants.bottomOffset.h + constants.navBarHeight.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
