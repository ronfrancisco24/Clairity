import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../models/notifications_model.dart';
import '../../providers/sensor_provider.dart';
import '../../services/notification_reading_service.dart';
import '../../widgets/notifications/notification_card.dart';
import '../../widgets/notifications/notification_filter.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String selectedFilter = "current"; // default filter


  @override
  Widget build(BuildContext context) {
    final sensorProvider = Provider.of<SensorProvider>(context);
    final sensorId = sensorProvider.sensorId;

    final currentNotifications =
        NotificationReadingService(sensorId!).streamNotifications('current');
    final forecastNotifications =
        NotificationReadingService(sensorId).streamNotifications('forecast');

    Stream<List<NotificationsModel>> selectedStream;

    // use for filtering notifications
    switch (selectedFilter) {
      case "forecast":
        selectedStream = forecastNotifications;
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
          Padding(
            padding: EdgeInsets.all(8.0),
            child: NotificationFilter(
                selectedFilter: selectedFilter,
                onChanged: (newSelection) {
                  setState(() {
                    selectedFilter = newSelection;
                  });
                }),
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
                            isUnread: !model.isRead,
                            onTap: () async {
                              await NotificationReadingService(sensorId).updateIsRead(
                                  notificationId: model.id,
                                  isRead: !model.isRead,
                                  type: model.type);
                            },
                          );
                        },
                      )
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.notifications_off,
                                  size: 100.sp, color: Colors.grey),
                              SizedBox(height: 20.h),
                              Text(
                                "No Notifications Yet!",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40.w, vertical: 10.h),
                                child: Text(
                                  "Please select a restroom to monitor for better experience!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14.sp),
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
