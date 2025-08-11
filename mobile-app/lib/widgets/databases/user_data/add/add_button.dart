import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddButton extends StatelessWidget{
  final VoidCallback onAdd;

  const AddButton({
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.w, 8.h, 0, 8.h),
      child: GestureDetector(
        onTap: onAdd,
        child: Container(
          width: 35.w,
          height: 35.w,
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.grey[300]!)
          ),
          child: Icon(
              Icons.add,
              color: Colors.grey[600],
              size: 16.w,
          ),
        ),
      ),
    );
  }
}