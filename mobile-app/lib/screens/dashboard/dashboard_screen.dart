import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/dashboard_manager.dart';
import '../../controllers/notification_manager.dart';
import '../../providers/log_provider.dart';
import 'package:provider/provider.dart';
import '../../services/notification_reading_service.dart';
import '../../widgets/dashboard/air_quality_section.dart';
import '../../widgets/dashboard/cleaned_time_tiles.dart';
import '../../widgets/dashboard/forecast_card.dart';
import '../../widgets/header.dart';
import '../../widgets/dashboard/card_location.dart';
import '../../widgets/dashboard/pollutant_grid.dart';
import '../../widgets/dashboard/card_message.dart';
import '../../utils/dashboard_utils.dart';
import '../../providers/sensor_provider.dart';
import '../../providers/user_provider.dart';
import '../../constants.dart' as constants;

//TODO: fix user creation error on real phone numbers SMS verification code request failed: unknown status code: 17028 null
//TODO: fix size constraints
//TODO: fix filtering and reset stream everytime.
//TODO: extract helper functions and keep this purely for building widgets only.
//TODO: fix current notifications not notifying
//TODO: add labels for easier user experience

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _dashboardService = DashboardService();
  final _notificationService = NotificationReadingService();
  final _notificationManager = NotificationManager();

  String? _selectedSensorId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await _notificationManager.setupNotificationHandlers(context);
        await _notificationService.saveDeviceToken();
        await _notificationService.setupTokenRefresh();
        await _initializeSensor();
      },
    );
  }

  Future<void> _initializeSensor() async {
    final sensorProvider = context.read<SensorProvider>();
    final logProvider = context.read<LogProvider>();

    await sensorProvider.loadSensorIds();

    if (sensorProvider.sensorIds.isNotEmpty) {
      // Only set if not already chosen
      _selectedSensorId = sensorProvider.sensorId;
      _dashboardService.setSensor(
        _selectedSensorId!,
        sensorProvider,
        logProvider,
      );

    } else {
      sensorProvider.setSensorId(sensorProvider.sensorIds.first);
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
    final sensorList = context.watch<SensorProvider>().sensorIds;

    final lastCurrentCleanedTime = context.watch<LogProvider>().lastCleanedTime;
    final nextCleaningTime = getNextCleaningTime(
        sensorProvider.currentData, sensorProvider.predictedData);

    final firstName = userProvider.user?.firstName;

    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                // Header
                DashboardHeader(title: 'Welcome $firstName!', hasDate: true),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ForecastCard(
                    category: sensorProvider.predictedData?.aqiCategory,
                    value: sensorProvider.predictedData?.aqi,
                    nextForecast: sensorProvider.predictedData?.timestamp,
                  ),
                ),
                // Air Quality & Trend Cards
                AirQualitySection(
                  selectedReading: selectedReading,
                  selectedSensorId: _selectedSensorId,
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
                Consumer<SensorProvider>(
                  builder: (context, provider, _) {
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
                  },
                ),
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
