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
    return Row(
      children: [
        TimeInfoTile(
          time: "$formattedLast", // readable format
          label: "Last Cleaned",
          icon: lastCleaned != null
              ? getTimeIcon(lastCleaned)
              : Icons.help_outline,
        ),
        const SizedBox(width: 12),
        TimeInfoTile(
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
