import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';

class CalendarDayItem extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final VoidCallback? onTap;

  const CalendarDayItem({
    Key? key,
    required this.date,
    required this.isSelected,
    required this.isToday,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null;

    Widget dayContent = Container(
      width: 40.w,
      height: 60.h,
      decoration: BoxDecoration(
        gradient: isSelected ? AppGradients.primaryGradient : null,
        color: isSelected ? null : Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _getDayName(date.weekday),
            style: TextStyle(
              fontSize: 10.sp,
              color: isDisabled
                  ? Colors.grey[400]
                  : isSelected
                  ? Colors.white
                  : Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            date.day.toString().padLeft(2, '0'),
            style: TextStyle(
              fontSize: 16.sp,
              color: isDisabled
                  ? Colors.grey[400]
                  : isSelected
                  ? Colors.white
                  : (isToday ? Colors.black : Colors.black87),
              fontWeight:
              isSelected || isToday ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    // Wrap with gradient border if it's today but not selected
    if (isToday && !isSelected) {
      dayContent = Container(
        padding: EdgeInsets.all(2.r),
        decoration: BoxDecoration(
          gradient: AppGradients.secondaryGradient,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // or theme background
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: dayContent,
        ),
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: dayContent,
    );
  }

  String _getDayName(int weekday) {
    List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }
}
