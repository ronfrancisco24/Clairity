import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ActionButtons({
    Key? key,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              'Action',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: onDelete,
                child: Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 16.w,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              // Copy Button (Gray)
              GestureDetector(
                onTap: onEdit,
                child: Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 16.w,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
