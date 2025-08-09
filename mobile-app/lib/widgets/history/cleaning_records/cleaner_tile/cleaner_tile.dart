import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/cleaning_log_model.dart';
import '../../../../utils/history_utils.dart';
import '../../../databases/cleaning_records_database/acknowledge_card/admin_message_container.dart';
import 'cleaner_tile_header.dart';
import 'cleaner_tile_user.dart';
import 'cleaner_tile_comment.dart';
import 'cleaner_tile_rating.dart';

class CleanerTile extends StatefulWidget {
  final CleaningRecord record;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CleanerTile({
    super.key,
    required this.record,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<CleanerTile> createState() => _CleanerTileState();
}

class _CleanerTileState extends State<CleanerTile> {
  late Color iconColor;

  @override
  void initState() {
    super.initState();
    iconColor = getRandomIconColor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: widget.record.acknowledged == true
            ? Border.all(color: iconColor, width: 2.w)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.person,
                  color: iconColor,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CleanerTileHeader(
                      record: widget.record,
                      onEdit: widget.onEdit,
                      onDelete: widget.onDelete,
                    ),
                    SizedBox(height: 4.h),
                    CleanerTileUser(record: widget.record),
                    SizedBox(height: 6.h),
                    CleanerTileComment(record: widget.record),
                    SizedBox(height: 8.h),
                    CleanerTileRating(record: widget.record),
                  ],
                ),
              ),
            ],
          ),
          if (widget.record.acknowledged == true) ...[
            Divider(),
            AdminMessageContainer(record: widget.record),
          ],
        ],
      ),
    );
  }
}