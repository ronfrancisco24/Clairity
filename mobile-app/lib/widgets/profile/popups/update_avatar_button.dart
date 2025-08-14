import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateAvatarButton extends StatelessWidget {
  final VoidCallback onTap;

  const UpdateAvatarButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.w,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: const Center(
          child: Text(
            "Update",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}