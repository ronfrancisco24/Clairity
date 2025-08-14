import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../models/cleaning_log_model.dart';
import '../../../../models/user_model.dart'; // Import UserModel
import '../../../../providers/user_provider.dart';
import '../../../../utils/history_utils.dart';
import '../../../databases/cleaning_records_database/acknowledge_card/admin_message_container.dart';
import 'cleaner_tile_header.dart';
import 'cleaner_tile_user.dart';
import 'cleaner_tile_comment.dart';
import 'cleaner_tile_rating.dart';
import '../../../../constants.dart' as constants;

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
  late Stream<UserModel?> _userDetails; // Store the future

  @override
  void initState() {
    super.initState();
    iconColor = getRandomIconColor();
    _userDetails = Provider.of<UserProvider>(context, listen: false)
        .userStreamById(widget.record.userId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userDetails = Provider.of<UserProvider>(context, listen: false)
        .userStreamById(widget.record.userId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
      stream: _userDetails, // The stream from your provider
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(16.w),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(16.w),
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final user = snapshot.data;

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
                  CircleAvatar(
                    radius: 20.r,
                    backgroundImage: user != null
                        ? AssetImage(constants.avatarImage[user.avatar ?? 0])
                        : null,
                    backgroundColor: Colors.grey[300],
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
                        CleanerTileUser(record: user),
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
      },
    );
  }
}