import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/cleaning_log_model.dart';

class CleanerTileUser extends StatelessWidget {
  final CleaningRecord record;

  const CleanerTileUser({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      record.userId.toString(),
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}
