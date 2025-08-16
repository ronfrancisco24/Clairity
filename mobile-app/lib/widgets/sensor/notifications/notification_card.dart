import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final int warningLevel;
  final String title;
  final String message;
  final DateTime time;
  final bool isUnread;
  final VoidCallback? onTap;
  final void Function(DismissDirection)? onDismiss;

  //TODO: implement update isRead onTap
  //TODO: implement delete onDismiss.

  const NotificationCard({
    super.key,
    required this.warningLevel,
    required this.title,
    required this.message,
    required this.time,
    this.onDismiss,
    this.onTap,
    this.isUnread = false,
  });

  @override
  Widget build(BuildContext context) {
    final List<Color> notificationColors = [
      Colors.blue, // Information
      Colors.green, // Good
      Colors.yellow, // Neutral
      Colors.orange, // Warning
      Colors.red, // Dangerous
    ];

    return Dismissible(
      key: UniqueKey(),
      // Temporary unique key each build
      direction: DismissDirection.endToStart,
      onDismissed: onDismiss,
      background: Container(
        color: Colors.red[500],
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.delete, color: Colors.white),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.circle,
                      size: 10.sp, color: notificationColors[warningLevel]),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                message,
                style: TextStyle(fontSize: 14.sp, color: Colors.black87),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Icon(Icons.access_time, size: 14.sp, color: Colors.grey),
                  SizedBox(width: 4.w),
                  Text(
                    DateFormat('MMM d, hh:mm a').format(time),
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),
                  if (isUnread) ...[
                    SizedBox(width: 12.w),
                    Icon(Icons.circle, size: 10.sp, color: Colors.blue),
                    SizedBox(width: 4.w),
                    Text(
                      "(Unread)",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                    ),
                  ]
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
