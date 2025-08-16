import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../models/notifications_model.dart';
import '../../providers/user_provider.dart';
import '../../services/notification_reading_service.dart';
import '../../widgets/sensor/notifications/notification_card.dart';
import '../../utils/notif_utils.dart';

//TODO: create a current and forecast section
//TODO: use sensorId based on selection
//TODO: use current_notifications for current tab

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  String selectedFilter = "current"; // default filter
  @override
  Widget build(BuildContext context) {

    const String sensorId = 'YDTdkdd2dSFsw6dtyvjd';

    final currentNotifications = NotificationReadingService(sensorId).streamNotifications('current');
    final forecastNotifications = NotificationReadingService(sensorId).streamNotifications('forecast');
    final allNotifications = NotificationReadingService(sensorId).streamNotifications('all');

    Stream<List<NotificationsModel>> selectedStream;

    // use for filtering notifications
    switch (selectedFilter) {
      case "forecast":
        selectedStream = forecastNotifications;
        break;
      case "all":
        selectedStream = allNotifications;
        break;
      default:
        selectedStream = currentNotifications;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Notifications",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        toolbarHeight: 56.h,
      ),

      body: Column(
        children: [
          //TODO: turn into widget.
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: "current", label: Text("Current")),
                ButtonSegment(value: "forecast", label: Text("Forecast")),
                ButtonSegment(value: "all", label: Text("All")),
              ],
              selected: {selectedFilter},
              onSelectionChanged: (newSelection) {
                setState(() {
                  selectedFilter = newSelection.first;
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<NotificationsModel>>(
              stream: selectedStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                final hasNotifications = data.isNotEmpty;
            
                return hasNotifications
                    ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final model = data[index];
            
                    return NotificationCard(
                      warningLevel: model.warningLevel,
                      title: model.title,
                      message: model.message,
                      time: model.timestamp,
                      isUnread: model.isRead,
                    );
            
                  },
                )
                    : Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_off, size: 100.sp, color: Colors.grey),
                        SizedBox(height: 20.h),
                        Text(
                          "No Notifications Yet!",
                          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                          child: Text(
                            "Please select a restroom to monitor for better experience!",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
