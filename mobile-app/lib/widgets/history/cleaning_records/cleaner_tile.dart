import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';
import '../../../models/cleaning_log_model.dart';
import '../../../utils/history_utils.dart';
import '../log_entry/log_bottomsheet.dart';

class CleanerTile extends StatelessWidget {
  final CleaningRecord record;

  const CleanerTile({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor = getRandomIconColor();

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Icon
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.person,
              color: iconColor,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Time and optional edit button
                Row(
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
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => LogBottomsheet(recordToEdit: record),
                          );
                        },
                        child: Icon(Icons.edit, size: 18.sp, color: Colors.grey[700]),
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  record.userId.toString(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  record.comment,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey[700],
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      'Rating',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Row(
                      children: List.generate(
                        5,
                            (index) => Icon(
                          index < record.rating ? Icons.star : Icons.star_border,
                          size: 16.sp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}