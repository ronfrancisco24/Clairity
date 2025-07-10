import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertTile extends StatelessWidget {
  final String date, alert, status;

  const AlertTile({
    super.key,
    required this.date,
    required this.alert,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.warning, color: Colors.redAccent),
        title: Text(alert, style: TextStyle(fontSize: 14.sp)),
        subtitle: Text("Date: $date\nStatus: $status", style: TextStyle(fontSize: 12.sp)),
      ),
    );
  }
}
