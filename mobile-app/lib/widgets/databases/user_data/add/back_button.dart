import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback onTap;

  const BackButtonWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 16.w,
        ),
      ),
    );
  }
}