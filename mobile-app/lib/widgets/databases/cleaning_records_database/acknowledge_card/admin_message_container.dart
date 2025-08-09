import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/cleaning_log_model.dart';

class AdminMessageContainer extends StatelessWidget {
  final CleaningRecord record;

  const AdminMessageContainer({
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: TextField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: '${record.adminMessage}',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            maxLines: 4,
        ),
      ),
    );
  }
}