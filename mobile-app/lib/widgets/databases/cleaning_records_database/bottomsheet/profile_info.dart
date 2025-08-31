import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/cleaning_log_model.dart';
import '../../../../models/user_model.dart';
import '../../../../constants.dart' as constants;

class ProfileInfo extends StatelessWidget {
  final CleaningRecord record;
  final UserModel user;

  const ProfileInfo({super.key, required this.record, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundImage:
                  AssetImage(constants.avatarImage[user.avatar ?? 0]),
              backgroundColor: Colors.grey[300],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              '${record.userId}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            Text(
              '${user.firstName} ${user.lastName}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
