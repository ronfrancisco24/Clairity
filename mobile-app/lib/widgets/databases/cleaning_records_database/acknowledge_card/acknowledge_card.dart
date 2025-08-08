import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/cleaning_log_model.dart';
import 'admin_message_container.dart';
import 'record_info.dart';

class AcknowledgeCard extends StatefulWidget {
  final CleaningRecord record;
  final VoidCallback onAcknowledge;
  final VoidCallback onDelete;

  const AcknowledgeCard({
    super.key,
    required this.record,
    required this.onAcknowledge,
    required this.onDelete,
  });

  @override
  State<AcknowledgeCard> createState() => _AcknowledgeCardState();
}

class _AcknowledgeCardState extends State<AcknowledgeCard> {
  String formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final amPm = dateTime.hour >= 12 ? 'pm' : 'am';
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute $amPm';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person, size: 20.sp, color: Colors.grey[700]),
              ),
              SizedBox(width: 12.w),
              RecordInfo(
                record: widget.record,
                onAcknowledge: widget.onAcknowledge,
                onDelete: widget.onDelete,
              ),
            ],
          ),
          if (widget.record.acknowledged == true) ...[
            Divider(),
            AdminMessageContainer(record: widget.record),
          ]
        ],
      ),
    );
  }
}