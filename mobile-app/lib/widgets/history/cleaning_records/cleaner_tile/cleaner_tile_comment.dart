import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/cleaning_log_model.dart';

class CleanerTileComment extends StatelessWidget {
  final CleaningRecord record;

  const CleanerTileComment({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      record.comment,
      style: TextStyle(
        fontSize: 13.sp,
        color: Colors.grey[700],
        height: 1.3,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
