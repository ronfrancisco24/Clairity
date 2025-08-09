import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/sensor_model.dart';
import '../../utils/sensor_data_utils.dart';
import 'package:provider/provider.dart';
import '../../widgets/sensor/notifications_button.dart';
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

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.loadUserData();
    _initializeSensorData();
  }

  void _initializeSensorData() async {
    String sensorId = "YDTdkdd2dSFsw6dtyvjd";

    String? readingId = await SensorReadingService().fetchLatestReadingId(
        sensorId);

    if (readingId != null) {
      Provider.of<SensorProvider>(context, listen: false)
          .listenToSensor(sensorId);
    } else {
      debugPrint("No latest reading found for sensor $sensorId");
    }
  }

  int selectedTimeIndex = 0;
  final List<String> times = generateTimeSlots();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

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
                          final current = provider.currentData;
                          final forecastList = provider.forecastReadingData;

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
                              // TODO: Navigate to sensor screen
                              await SensorReadingService()
                                  .generateTestSensorData(
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
                CardMessage(
                  message:
                      'Air quality in CR2 is unhealthy.\nRecommend airing out the room or limiting occupancy.',
                ),
                SizedBox(height: 16.h),
                // Pollutant Cards

                Consumer<SensorProvider>(builder: (context, provider, _) {
                  final current = provider.currentData;
                  final forecastList = provider.forecastReadingData;

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
                        //TODO: use state management tool to keep data consistent
                        pollutantList: pollutants, // show placeholder data
                      );
                    },
                  );
                }),
                SizedBox(height: 42.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
