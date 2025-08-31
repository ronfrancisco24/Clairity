import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../models/cleaning_log_model.dart';
import '../../../../models/user_model.dart';
import '../../../../providers/log_provider.dart';
import 'admin_message.dart';
import 'profile_info.dart';
import 'record_description/record_info_container.dart';

class AcknowledgeBottomSheet extends StatefulWidget {
  final CleaningRecord record;
  final UserModel user;

  const AcknowledgeBottomSheet(
      {super.key, required this.record, required this.user});

  @override
  State<AcknowledgeBottomSheet> createState() => _AcknowledgeBottomSheetState();
}

class _AcknowledgeBottomSheetState extends State<AcknowledgeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    @override
    void dispose() {
      _controller.dispose(); // Always dispose controllers!
      super.dispose();
    }

    return FractionallySizedBox(
      heightFactor: 0.85,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          border: const Border(
            top: BorderSide(color: Colors.black, width: 2.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 14.w),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              ProfileInfo(
                record: widget.record,
                user: widget.user,
              ),
              SizedBox(
                height: 10.h,
              ),
              RecordInfoContainer(record: widget.record),
              SizedBox(height: 10.h),
              // Admin comment widget
              AdminMessage(
                controller: _controller,
                onSubmit: () {
                  final message = _controller.text.trim().isEmpty
                      ? "Acknowledged."
                      : _controller.text.trim();

                  context.read<LogProvider>().updateLog(
                        widget.record.cleaningId,
                        acknowledged: true,
                        adminMessage: message,
                      );

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
