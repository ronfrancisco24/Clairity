import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/dashboard_manager.dart';
import '../../providers/log_provider.dart';
import 'package:provider/provider.dart';
import '../../services/notification_reading_service.dart';
import '../../services/sensor_reading_service.dart';
import '../../utils/navbar_utils.dart';
import '../../widgets/dashboard/cleaned_time_tiles.dart';
import '../../widgets/dashboard/forecast_card.dart';
import '../../widgets/header.dart';
import '../../widgets/dashboard/card_location.dart';
import '../../widgets/dashboard/aqi_card.dart';
import '../../widgets/dashboard/card_quality.dart';
import '../../widgets/dashboard/pollutant_grid.dart';
import '../../widgets/dashboard/card_message.dart';
import '../../utils/dashboard_utils.dart';
import '../../providers/sensor_provider.dart';
import '../../providers/user_provider.dart';
import '../../constants.dart' as constants;

//TODO: edit dashboard screen and notifications.
//TODO: just provide current data under selected reading instead.
//TODO: have two boxes the showcase aqi in the next 30 and 60 minutes.
//TODO: edit notifications to match the new format.
//TODO: forecast notifcations should also be established in firebase cloud push.
//TODO: dedupId should now be set for all notifcations, so setup a global deviceTokens collection.

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardService _dashboardService = DashboardService();

  int selectedTimeIndex = 0;
  final List<String> times = generateTimeSlots();
  String? _selectedSensorId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializeSensor();
    });
  }

  Future<void> _initializeSensor() async {
    final sensorProvider = context.read<SensorProvider>();
    final logProvider = context.read<LogProvider>();

    await sensorProvider.loadSensorIds(); // wait for Firestore

    if (sensorProvider.sensorIds.isNotEmpty) {
      // Only set if not already chosen
      if (sensorProvider.sensorId == null) {
        sensorProvider.setSensorId(sensorProvider.sensorIds.first);
      }

      _selectedSensorId = sensorProvider.sensorId;

      _dashboardService.setSensor(
        _selectedSensorId!,
        sensorProvider,
        logProvider,
      );
    }
  }


  void _setSensor(String sensorId) {
    final sensorProvider = context.read<SensorProvider>();
    final logProvider = context.read<LogProvider>();

    setState(() => _selectedSensorId = sensorId);
    _dashboardService.setSensor(sensorId, sensorProvider, logProvider);
  }

  @override
  void dispose() {
    _dashboardService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final sensorProvider = context.watch<SensorProvider>();

    final selectedReading = sensorProvider.currentData;
        // _dashboardService.getSelectedReading(sensorProvider, selectedTimeIndex);
    final sensorList = context.watch<SensorProvider>().sensorIds;

    final lastCurrentCleanedTime = context.watch<LogProvider>().lastCleanedTime;
    final nextCleaningTime = getNextCleaningTime(
        sensorProvider.currentData, sensorProvider.forecastReadingData);

    final firstName = userProvider.user?.firstName;

    ScreenUtil.init(context, designSize: const Size(360, 690));

    print(sensorProvider.forecastReadingData);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                // Header
                DashboardHeader(title: 'Welcome ${firstName}!', hasDate: true),
                SizedBox(height: 16.h),
                // Location Card
                CardLocation(
                  sensors: sensorList,
                  imageUrl:
                      'https://images.unsplash.com/photo-1569122243657-3c1c51340f65?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  title: '1st Restroom',
                  subtitle: (_selectedSensorId != null)
                      ? 'Current Sensor: $_selectedSensorId'
                      : 'No Sensor Selected',
                  onSensorPicked: (sensorId) {
                    _setSensor(sensorId);
                  },
                ),
                // Time Selector
                // SizedBox(
                //   height: 32.h,
                //   child: TimeSelector(
                //     times: times,
                //     selectedIndex: selectedTimeIndex,
                //     onSelected: (index) {
                //       setState(() {
                //         selectedTimeIndex = index;
                //       });
                //     },
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ForecastCard(
                    category: sensorProvider.forecastReadingData?.aqiCategory,
                    value: sensorProvider.forecastReadingData?.aqi,
                  ),
                ),
                // Air Quality & Trend Cards
                Row(
                  children: [
                    // Currents Card
                    Expanded(
                      child: Consumer<SensorProvider>(
                        builder: (context, provider, _) {
                          // You can adjust how you calculate these
                          final value = (selectedReading?.aqi ?? 0);
                          final status =
                              selectedReading?.aqiCategory ?? 'Unknown';
                          return AqiCard(
                            value: value,
                            status: status,
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer<SensorProvider>(
                            builder: (context, provider, _) {
                              final highest = selectedReading != null
                                  ? getHighestPollutant(selectedReading)
                                  : null;
                              final level = highest != null
                                  ? getPollutantLevel(highest.value)
                                  : null;
                              return CardQuality(
                                onTap: () async {
                                  if (_selectedSensorId == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("No sensor selected")),
                                    );
                                    return;
                                  }
                                  await SensorReadingService().generateRawTestData(_selectedSensorId!);
                                  NavController.of(context)?.onNavSelect(
                                      constants.NavRoute.history,
                                      initialIndex: 2);
                                },
                                trendLabel: 'Air Quality Trend',
                                trendValue: highest?.key ?? '--',
                                trendLevel: level ?? 'No Data',
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Warning
                CardMessage(
                  message: selectedReading == null
                      ? 'No air quality data available.'
                      : getAqiMessage(selectedReading.aqiCategory ?? 'Unknown'),
                ),
                const SizedBox(height: 16),
                CleanedTimeTiles(
                  lastCleaned: lastCurrentCleanedTime,
                  nextCleaned: nextCleaningTime,
                ),
                const SizedBox(height: 16),
                // Pollutant Cards
                Consumer<SensorProvider>(builder: (context, provider, _) {
                  final List<Map<String, dynamic>> pollutants =
                      selectedReading != null
                          ? getCurrentData(selectedReading)
                          : [];
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return PollutantGrid(
                        pollutantList: pollutants, // show placeholder data
                      );
                    },
                  );
                }),
                const SizedBox(
                    height: constants.bottomOffset + constants.navBarHeight),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
