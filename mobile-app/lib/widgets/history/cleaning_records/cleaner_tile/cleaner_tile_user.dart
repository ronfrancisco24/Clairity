import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/user_model.dart';

class CleanerTileUser extends StatelessWidget {
  final UserModel? record;

  const CleanerTileUser({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      record!.username,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}
