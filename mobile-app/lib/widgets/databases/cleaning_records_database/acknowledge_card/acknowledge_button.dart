import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/cleaning_log_model.dart';

class AcknowledgeButton extends StatelessWidget {
  final CleaningRecord record;
  final VoidCallback onAcknowledge;

  const AcknowledgeButton({
    super.key,
    required this.record,
    required this.onAcknowledge,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: record.acknowledged ? null : onAcknowledge,
        style: ElevatedButton.styleFrom(
          backgroundColor:
          record.acknowledged ? Colors.blue[300] : Colors.blue[700],
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          minimumSize: Size(0, 30.h),
        ),
        child: Text(
          record.acknowledged ? "Acknowledged" : "Acknowledge",
          style: TextStyle(fontSize: 12.sp, color: Colors.white),
        ),
      ),
    );
  }
}
