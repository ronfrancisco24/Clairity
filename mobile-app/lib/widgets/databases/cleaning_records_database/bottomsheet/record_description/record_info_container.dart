import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../models/cleaning_log_model.dart';
import 'record_info_row.dart';

class RecordInfoContainer extends StatelessWidget {
  final CleaningRecord record;

  const RecordInfoContainer({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rating',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Color(0xFF000000).withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: List.generate(
                      5,
                          (index) => Icon(
                        index <= record.rating ? Icons.star : Icons.star_border,
                        size: 16.sp,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RecordInfoRow(label: "Record Number", value: record.cleaningId),
            RecordInfoRow(label: "Timestamp", value: record.timestamp.toString()),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Message',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Color(0xFF000000).withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.h),
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: record.comment,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}