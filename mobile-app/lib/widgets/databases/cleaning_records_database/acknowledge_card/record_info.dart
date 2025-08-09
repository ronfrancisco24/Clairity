import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/cleaning_log_model.dart';
import 'delete_button.dart';
import 'acknowledge_button.dart';

class RecordInfo extends StatelessWidget {
  final CleaningRecord record;
  final VoidCallback onAcknowledge;
  final VoidCallback onDelete;

  const RecordInfo({
    required this.record,
    required this.onAcknowledge,
    required this.onDelete,
  });

  String formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final amPm = dateTime.hour >= 12 ? 'pm' : 'am';
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute $amPm';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${record.userId}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
              Text(
                formatTime(record.timestamp),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            "Sensor ${record.sensorId}",
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 4.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  record.comment,
                  style: TextStyle(fontSize: 13.sp),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              AcknowledgeButton(
                record: record,
                onAcknowledge: onAcknowledge,
              ),
              SizedBox(width: 10.w),
              DeleteButton(onDelete: onDelete),
            ],
          ),
        ],
      ),
    );
  }
}