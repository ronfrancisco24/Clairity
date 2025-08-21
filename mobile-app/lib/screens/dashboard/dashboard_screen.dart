import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../models/sensor_model_details.dart';
import '../../providers/log_provider.dart';
import '../../utils/sensor_utils.dart';
import 'package:provider/provider.dart';
import '../../widgets/history/sensor_chart/sensor_data_tab.dart';
import '../../widgets/sensor/notifications/notifications_button.dart';
import '../../widgets/dashboard/card_location.dart';
import '../../widgets/dashboard/aqi_card.dart';
import '../../widgets/dashboard/card_quality.dart';
import '../../widgets/dashboard/pollutant_grid.dart';
import '../../widgets/dashboard/time_selector.dart';
import '../../widgets/dashboard/card_message.dart';
import '../../utils/dashboard_utils.dart';
import '../../providers/sensor_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/sensor_reading_service.dart';
import '../../constants.dart' as constants;
import '../../widgets/sensor/time_info_tile.dart';

//TODO: change card current to select sensors
//TODO: modularize code.

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedTimeIndex = 0;
  final List<String> times = generateTimeSlots();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final sensorProvider =
          Provider.of<SensorProvider>(context, listen: false);
      sensorProvider.initializeSensorListener();

      final logProvider = Provider.of<LogProvider>(context, listen: false);
      logProvider.listenToLatestCleanedTime("YDTdkdd2dSFsw6dtyvjd");
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEE, MMMM d').format(DateTime.now());
    final userProvider = Provider.of<UserProvider>(context);
    final current = context.watch<SensorProvider>().currentData;
    final forecastList = context.watch<SensorProvider>().forecastReadingData;
    final lastCurrentCleanedTime = context.watch<LogProvider>().lastCleanedTime;
    final formattedTime =
        lastCurrentCleanedTime != null ? getFormattedTime(lastCurrentCleanedTime) : "No record yet";

    final firstName = (userProvider.user?.firstName ?? 'No name').toString();

    SensorDetails? selectedReading;
    if (selectedTimeIndex == 0) {
      selectedReading = current;
    } else if (selectedTimeIndex - 1 < forecastList.length) {
      selectedReading = forecastList[selectedTimeIndex - 1];
    }

    final nextCleaningTime= getNextCleaningTime(selectedReading, forecastList);
    final formattedNextCleanedTime = getFormattedTime(nextCleaningTime!);

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
                          '$formattedDate',
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
                  title: '1st Restroom',
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
                    // Quality Card
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer<SensorProvider>(
                            builder: (context, provider, _) {
                              final highest = selectedReading != null ? getHighestPollutant(selectedReading) : null;
                              final level = highest != null ? getPollutantLevel(highest.value) : null;

                              return CardQuality(
                                onTap: () async {
                                  await SensorReadingService().generateRawTestData('YDTdkdd2dSFsw6dtyvjd');
                                },
                                trendLabel: 'Air Quality Trend',
                                trendValue: highest?.key ?? '--',
                                trendLevel: level ?? 'No Data',
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Warning
                //TODO: show warning message
                CardMessage(
                  message: selectedReading == null
                      ? 'No air quality data available.'
                      : getAqiMessage(selectedReading!.aqiCategory ?? 'Unknown'),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    TimeInfoTile(
                      time: "$formattedTime", // readable format
                      label: "Last Cleaned",
                      icon: lastCurrentCleanedTime != null
                          ? getTimeIcon(lastCurrentCleanedTime)
                          : Icons.help_outline,
                    ),
                    const SizedBox(width: 12),
                    TimeInfoTile(
                        time: "$formattedNextCleanedTime",
                        label: "Clean Again By",
                        icon: lastCurrentCleanedTime != null
                            ? getTimeIcon(nextCleaningTime)
                            : Icons.help_outline,),
                  ],
                ),
                SizedBox(height: 16),
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
                SizedBox(
                    height:
                        constants.bottomOffset.h + constants.navBarHeight.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
