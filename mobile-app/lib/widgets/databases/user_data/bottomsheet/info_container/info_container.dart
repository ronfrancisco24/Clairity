import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'detail_row.dart';
import 'action_buttons.dart';
import '../action_type.dart';

class InfoContainer extends StatelessWidget {
  final Map<String, dynamic> user;
  final void Function(ActionType) onActionSelected;

  const InfoContainer({
    Key? key,
    required this.user,
    required this.onActionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DetailRow(label: 'Name', value: user['name']),
            DetailRow(label: 'Username', value: user['username']),
            DetailRow(label: 'Phone', value: user['phoneNo']),
            DetailRow(label: 'Building', value: user['assignedBuilding']),
            DetailRow(label: 'Logs', value: user['submittedLogs'].toString()),
            ActionButtons(
              onDelete: () => onActionSelected(ActionType.delete),
              onEdit: () => onActionSelected(ActionType.edit),
            ),
          ],
        ),
      ),
    );
  }
}
