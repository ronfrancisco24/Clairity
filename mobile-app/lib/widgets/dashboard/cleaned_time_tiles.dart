import 'package:flutter/material.dart';
import 'time_info_tile.dart';
import '../../utils/dashboard_utils.dart';

class CleanedTimeTiles extends StatelessWidget {

  DateTime? lastCleaned;
  DateTime? nextCleaned;

  CleanedTimeTiles({super.key, required this.lastCleaned, this.nextCleaned});

  @override
  Widget build(BuildContext context) {

    final formattedLast =
    lastCleaned != null ? getFormattedTime(lastCleaned!) : 'No record yet';
    final formattedNext =
    nextCleaned != null ? getFormattedTime(nextCleaned!) : 'No prediction yet';

    final lastCleanedDate = lastCleaned != null ? getFormattedMonth(lastCleaned!) : '';
    final nextCleaningDate = nextCleaned != null ? getFormattedMonth(nextCleaned!) : '';

    print(lastCleaned);
    print(nextCleaned);

    return Row(
      children: [
        TimeInfoTile(
          date: "$lastCleanedDate",
          time: "$formattedLast", // readable format
          label: "Last Cleaned",
          icon: lastCleaned != null
              ? getTimeIcon(lastCleaned)
              : Icons.help_outline,
        ),
        const SizedBox(width: 12),
        TimeInfoTile(
          date: "$nextCleaningDate",
          time: "$formattedNext",
          label: "Clean Again By",
          icon: nextCleaned != null
              ? getTimeIcon(
              nextCleaned)
              : Icons.help_outline,
        ),
      ],
    );
  }
}
