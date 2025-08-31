import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../models/notifications_model.dart';
import '../../../providers/sensor_provider.dart';
import '../../../services/history_reading_service.dart';
import '../../../utils/history_utils.dart';
import 'alert_tile.dart';
import '../cleaner_calendar.dart';
import '../../../constants.dart' as constants;
import '../../../utils/dashboard_utils.dart';


//TODO: listen to all notifications.

class PastAlertsTab extends StatefulWidget {
  const PastAlertsTab({super.key});

  @override
  State<PastAlertsTab> createState() => _PastAlertsTabState();
}

class _PastAlertsTabState extends State<PastAlertsTab> {
  DateTime selectedDate = DateTime.now();

  String get formattedDate {
    return formatSelectedDate(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final sensorProvider = Provider.of<SensorProvider>(context);
    final sensorId = sensorProvider.sensorId;

    return Container(
      color: Colors.grey[50],
      child: Column(
        children: [
          CalendarWidget(
            selectedDate: selectedDate,
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            },
          ),
          Container(
            height: 56,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time, size: 16.sp, color: Colors.white),
                SizedBox(width: 8.w),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: StreamBuilder<List<NotificationsModel>>(
                  stream: streamAlertData('$sensorId', selectedDate),
                  builder: (context, snapshot) {

                    if (snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError){
                      return Center(
                        child: Text(
                          "Error: ${snapshot.error}.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[700],
                          ),
                        )
                      );
                    }

                    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 130),
                        child: Center(
                          child: Text(
                            "No alerts for this day.",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      );
                    }


                    final records = snapshot.data!;

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: records.length + 1,
                      itemBuilder: (context, index) {
                        if (index == records.length) {
                          return SizedBox(
                            height: constants.bottomOffset.h + constants.navBarHeight.h,
                          );
                        }

                        final alert = records[records.length - 1 - index];

                        return AlertTile(
                          date: alert.timestamp,
                          alert: getAlertLabel(alert.warningLevel),
                          level: alert.warningLevel,
                        );
                      },
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }

}
