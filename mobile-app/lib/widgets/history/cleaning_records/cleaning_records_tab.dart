import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/history_utils.dart';
import 'cleaner_tile.dart';
import '../cleaner_calendar.dart';
import '../../../constants.dart' as constants;
import '../../../models/cleaning_log_model.dart';

//TODO: Username based on userId

class CleaningRecordsTab extends StatefulWidget {
  const CleaningRecordsTab({super.key});

  @override
  State<CleaningRecordsTab> createState() => _CleaningRecordsTabState();
}

class _CleaningRecordsTabState extends State<CleaningRecordsTab> {
  DateTime selectedDate = DateTime.now();

  // Sample data using CleaningLog model
  final List<CleaningRecord> cleaningRecords = [
    CleaningRecord(
      timestamp: DateTime(2025, 7, 14, 14, 22),
      cleaningId: 1,
      restroomId: 1,
      userId: 001,
      comment: 'Smelled bad, cleaned thoroughly',
      rating: 4,
    ),
    CleaningRecord(
      timestamp: DateTime(2025, 7, 14, 15, 22),
      cleaningId: 2,
      restroomId: 1,
      userId: 002,
      comment: 'Regular cleaning, mopped the floor',
      rating: 3,
    ),
    CleaningRecord(
      timestamp: DateTime(2025, 7, 17, 16, 22),
      cleaningId: 3,
      restroomId: 2,
      userId: 003,
      comment: 'Collaborative session with international team, light cleanup',
      rating: 4,
    ),
    CleaningRecord(
      timestamp: DateTime(2025, 7, 14, 13, 22),
      cleaningId: 4,
      restroomId: 1,
      userId: 004,
      comment: 'Disinfected all surfaces thoroughly',
      rating: 5,
    ),
    CleaningRecord(
      timestamp: DateTime(2025, 1, 7, 12, 22),
      cleaningId: 5,
      restroomId: 3,
      userId: 005,
      comment: 'Cleaned quickly but missed a few spots',
      rating: 2,
    ),
  ];

  List<CleaningRecord> get filteredRecords {
    return filterRecordsByDate(cleaningRecords, selectedDate);
  }

  String get formattedDate => formatSelectedDate(selectedDate);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: Column(
        children: [
          CalendarWidget(
            selectedDate: selectedDate,
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            },
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16.sp,
                  color: Colors.white,
                ),
                SizedBox(width: 8.w),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(12.r),
            ),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: filteredRecords.isEmpty
                ? Padding(
              padding: const EdgeInsets.only(bottom: 130),
              child: Center(
                child: Text(
                  "No cleaning records for this day.",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            )
                : SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: constants.bottomOffset.h + 100),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: filteredRecords.length,
                  itemBuilder: (context, index) {
                    final record = filteredRecords[index];
                    return CleanerTile(
                      userId: record.userId,
                      comment: record.comment,
                      rating: record.rating,
                      date: record.timestamp,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
