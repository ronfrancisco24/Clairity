import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../constants.dart';
import '../../../../models/cleaning_log_model.dart';

class CleanerTileHeader extends StatelessWidget {
  final CleaningRecord record;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CleanerTileHeader({
    super.key,
    required this.record,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.access_time, size: 12.sp, color: Colors.grey[600]),
            SizedBox(width: 4.w),
            Text(
              DateFormat('hh:mm a').format(record.timestamp),
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        if (record.userId == currentUserId)
          Row(
            children: [
              GestureDetector(
                onTap: onEdit,
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Icon(Icons.edit, size: 18.sp, color: Colors.grey[700]),
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: onDelete,
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Icon(Icons.delete_forever, size: 18.sp, color: Colors.red[600]),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
