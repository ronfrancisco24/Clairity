import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../models/cleaning_log_model.dart';
import '../../../providers/log_provider.dart';
import '../../../utils/history_utils.dart';
import '../../history/cleaner_calendar.dart';
import '../../../constants.dart' as constants;
import 'acknowledge_card.dart';
import 'bottomsheet/acknowledge_bottomsheet.dart';

//TODO: Username based on userId

class CleaningRecordsDatabaseTab extends StatefulWidget {
  const CleaningRecordsDatabaseTab({super.key});

  @override
  State<CleaningRecordsDatabaseTab> createState() => _CleaningRecordsDatabaseTabState();
}

class _CleaningRecordsDatabaseTabState extends State<CleaningRecordsDatabaseTab> {
  DateTime selectedDate = DateTime.now();
  List<CleaningRecord> records = constants.sampleLogs;

  String get formattedDate => formatSelectedDate(selectedDate);

  @override
  Widget build(BuildContext context) {
    final logs = context.watch<LogProvider>().logs;
    final filteredLogs = filterRecordsByDate(records, selectedDate);

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

                    return AcknowledgeCard(
                      record: record,
                      onAcknowledge: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => AcknowledgeBottomSheet(record: record),
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

String formatTime(DateTime dateTime) {
  final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
  final amPm = dateTime.hour >= 12 ? 'pm' : 'am';
  final minute = dateTime.minute.toString().padLeft(2, '0');
  return '$hour:$minute $amPm';
}