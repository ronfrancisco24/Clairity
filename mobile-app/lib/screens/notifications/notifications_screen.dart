import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/sensor/notification_card.dart';
import '../../utils/notif_utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final StreamController<List<Map<String, dynamic>>> _streamController =
  StreamController<List<Map<String, dynamic>>>.broadcast();

  late List<Map<String, dynamic>> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = _getSampleNotifications();
    _startPeriodicUpdate();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void _startPeriodicUpdate() {
    Timer.periodic(const Duration(seconds: 10), (_) {
      _streamController.add(_notifications);
    });
  }

  List<Map<String, dynamic>> _getSampleNotifications() {
    final now = DateTime.now();
    return [
      {
        "warningLevel": 4,
        "title": "Vape Smoke Detected",
        "message": "Suspected cigarette smoke in Male Restroom (1st Floor)",
        "time": DateTime(now.year, now.month, now.day, 22, 50),
        "isUnread": true,
      },
      {
        "warningLevel": 3,
        "title": "Poor Air Quality Detected",
        "message": "PM2.5 level exceeded in Female Restroom (2nd Floor)",
        "time": DateTime(now.year, now.month, now.day, 22, 34),
        "isUnread": true,
      },
      {
        "warningLevel": 0,
        "title": "Sensor Restored",
        "message": "Air quality sensor reconnected in Ground Floor Restroom",
        "time": DateTime(now.year, now.month, now.day, 21, 55),
        "isUnread": false,
      },
      {
        "warningLevel": 2,
        "title": "CO₂ Level Rising",
        "message": "CO₂ levels nearing unsafe threshold in Female Restroom",
        "time": DateTime(now.year, now.month, now.day, 20, 2),
        "isUnread": true,
      },
      {
        "warningLevel": 1,
        "title": "Restroom Air Quality Normal",
        "message": "Air quality back to safe levels in Male Restroom",
        "time": DateTime(now.year, now.month, now.day, 19, 50),
        "isUnread": false,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _streamController.stream,
        initialData: _notifications,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          final hasNotifications = data.isNotEmpty;

          return hasNotifications
              ? ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];

              print(item["time"]);

              return NotificationCard(
                warningLevel: item["warningLevel"],
                title: item["title"],
                message: item["message"],
                time: getTimeAgo(item["time"]),
                isUnread: item["isUnread"],
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
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    ),
                    child: Text("Refresh", style: TextStyle(fontSize: 14.sp)),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
