import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'calendar_week_view.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const CalendarWidget({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late PageController _pageController;
  final DateTime startDate = DateTime(2025, 1, 1);
  final DateTime today = DateTime.now();
  late int initialPage;
  late int maxPage;

  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  @override
  void initState() {
    super.initState();
    final startOfWeekToday = _getStartOfWeek(today);
    final startOfWeekStartDate = _getStartOfWeek(startDate);
    final daysSinceStart = startOfWeekToday.difference(startOfWeekStartDate).inDays;
    initialPage = daysSinceStart ~/ 7;
    maxPage = initialPage;
    _pageController = PageController(initialPage: initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              _getMonthYearText(widget.selectedDate),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 80.h,
            child: PageView.builder(
              controller: _pageController,
              itemCount: maxPage + 1,
              onPageChanged: (index) {
                DateTime newDate = startDate.add(Duration(days: index * 7));
                if (newDate.isBefore(today) || _isSameDay(newDate, today)) {
                  widget.onDateSelected(newDate);
                }
              },
              itemBuilder: (context, pageIndex) {
                return CalendarWeekView(
                  pageIndex: pageIndex,
                  selectedDate: widget.selectedDate,
                  onDateSelected: widget.onDateSelected,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getMonthYearText(DateTime date) {
    List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}
