import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../providers/log_provider.dart';
import '../../../utils/history_utils.dart';
import '../log_entry/log_bottomsheet.dart';
import 'cleaner_tile/cleaner_tile.dart';
import '../cleaner_calendar.dart';
import '../../../constants.dart' as constants;

class CleaningRecordsTab extends StatefulWidget {
  const CleaningRecordsTab({super.key});

  @override
  State<CleaningRecordsTab> createState() => _CleaningRecordsTabState();
}

class _CleaningRecordsTabState extends State<CleaningRecordsTab> {
  DateTime selectedDate = DateTime.now();
  String get formattedDate => formatSelectedDate(selectedDate);

  @override
  void initState() {
    super.initState();
    context.read<LogProvider>().fetchLogs(); // Make sure this method exists
  }

  @override
  Widget build(BuildContext context) {
    final logs = context.watch<LogProvider>().logs;
    final filteredLogs = filterRecordsByDate(logs, selectedDate);

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
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(12.r),
            ),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
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
                Spacer(),
                SizedBox(
                  width: 30.w,
                  height: 30.h,
                  child: (selectedDate.year == DateTime.now().year &&
                      selectedDate.month == DateTime.now().month &&
                      selectedDate.day == DateTime.now().day)
                      ? IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 20.sp,
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (_) => const LogBottomsheet(),
                            );
                          },
                          icon: Icon(Icons.add, color: Colors.white),
                        )
                      : const SizedBox.shrink(), // Keeps space but shows nothing
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: filteredLogs.isEmpty
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
                  itemCount: filteredLogs.length,
                  itemBuilder: (context, index) {
                    final record = filteredLogs[index];
                    return CleanerTile(
                      record: record,
                      onEdit: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => LogBottomsheet(recordToEdit: record),
                        );
                      },
                      onDelete: () {
                        context.read<LogProvider>().removeLog(record.cleaningId);
                      },
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