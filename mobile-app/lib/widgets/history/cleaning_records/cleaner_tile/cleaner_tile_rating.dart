import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/cleaning_log_model.dart';

class CleanerTileRating extends StatelessWidget {
  final CleaningRecord record;

  const CleanerTileRating({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
