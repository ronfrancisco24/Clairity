import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'notifications/notifications_button.dart';

class DashboardHeader extends StatelessWidget {
  final String? title;
  final bool? hasDate;

  const DashboardHeader({super.key, this.title, required this.hasDate});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEEE, MMMM d').format(DateTime.now());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        hasDate! ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$title',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 4),
           Text(
              formattedDate,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ) :
        Text('$title',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        const NotificationsButton(),
      ],
    );
  }
}
