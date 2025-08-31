import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../models/user_model.dart';
import '../../../providers/log_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/history_utils.dart';
import '../../history/cleaner_calendar.dart';
import '../../../constants.dart' as constants;
import 'acknowledge_card/acknowledge_card.dart';
import 'bottomsheet/acknowledge_bottomsheet.dart';

//TODO: Username based on userId

class CleaningRecordsDatabaseTab extends StatefulWidget {
  const CleaningRecordsDatabaseTab({super.key});

  @override
  State<CleaningRecordsDatabaseTab> createState() => _CleaningRecordsDatabaseTabState();
}

class _CleaningRecordsDatabaseTabState extends State<CleaningRecordsDatabaseTab> {
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Divider(),
          ),
          SizedBox(height: 10.h,),
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
                : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: filteredLogs.length + 1, // add 1 for SizedBox
              itemBuilder: (context, index) {
                if (index == filteredLogs.length) {
                  return SizedBox(
                    height: constants.bottomOffset.h + constants.navBarHeight.h,
                  );
                }

                final record = filteredLogs[index];
                final recordId = record.userId;

                return FutureBuilder<UserModel?>(
                  future: Provider.of<UserProvider>(context, listen: false)
                      .getUserDetailsById(recordId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData) {
                      return const SizedBox(); // or placeholder if user not found
                    }

                    final user = snapshot.data!;

                    return AcknowledgeCard(
                      record: record,
                      onAcknowledge: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => AcknowledgeBottomSheet(
                            record: record,
                            user: user,
                          ),
                        );
                      },
                      onDelete: () {
                        context.read<LogProvider>().removeLog(record.cleaningId);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}