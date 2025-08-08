import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/cleaning_log_model.dart';
import 'admin_message.dart';
import 'profile_info.dart';
import 'record_description/record_info_container.dart';

class AcknowledgeBottomSheet extends StatelessWidget {
  final CleaningRecord record;

  const AcknowledgeBottomSheet({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.85,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          border: const Border(
            top: BorderSide(color: Colors.black, width: 2.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 14.w),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              ProfileInfo(record: record),
              SizedBox(height: 10.h,),
              RecordInfoContainer(record: record),
              SizedBox(height: 10.h),

              // Admin comment widget
              AdminMessage(
                onSubmit: () {
                  // Handle the acknowledge logic here
                  // For example:
                  // 1. Set record.acknowledged = true
                  // 2. Add adminMessage
                  // 3. Call a provider method or backend service

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}