import 'package:flutter/material.dart';

import '../../../constants.dart';

class NotificationFilter extends StatefulWidget {
  final String selectedFilter;
  final ValueChanged<String> onChanged;

  NotificationFilter(
      {required this.selectedFilter, required this.onChanged, super.key});

  @override
  State<NotificationFilter> createState() => _NotificationFilterState();
}

class _NotificationFilterState extends State<NotificationFilter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<String>(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          foregroundColor: WidgetStatePropertyAll(Colors.black)
        ),
        segments: const [
          ButtonSegment(value: "current", label: Text("Current")),
          ButtonSegment(value: "forecast", label: Text("Forecast")),
        ],
        selected: {widget.selectedFilter},
        onSelectionChanged: (newSelection) {
          setState(() {
            widget.onChanged(newSelection.first);
          });
        },
      ),
    );
  }
}
