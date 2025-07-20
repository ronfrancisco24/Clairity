import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderIconToggleButton extends StatelessWidget {
  final IconData icon;
  final String gender;
  final String selectedGender;
  final VoidCallback onTap;

  const GenderIconToggleButton({
    required this.icon,
    required this.gender,
    required this.selectedGender,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = gender == selectedGender;
    final Color bgColor = gender == 'Male'
        ? Colors.blue
        : gender == 'Female'
        ? Colors.pink
        : Colors.grey;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: isSelected ? bgColor : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.black87,
          size: 16.sp,
        ),
      ),
    );
  }
}
