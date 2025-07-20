import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'calendar_day_item.dart';

class CalendarWeekView extends StatelessWidget {
  final int pageIndex;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const CalendarWeekView({
    Key? key,
    required this.pageIndex,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final startOfWeek = _getStartOfWeek(DateTime(2025, 1, 1)).add(Duration(days: pageIndex * 7));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final day = startOfWeek.add(Duration(days: index));
        final isInFuture = day.isAfter(DateTime(now.year, now.month, now.day));
        final isSelected = _isSameDay(day, selectedDate);
        final isToday = _isSameDay(day, now);

        return CalendarDayItem(
          date: day,
          isSelected: isSelected,
          isToday: isToday,
          onTap: isInFuture ? null : () => onDateSelected(day),
        );
      }),
    );
  }

  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
