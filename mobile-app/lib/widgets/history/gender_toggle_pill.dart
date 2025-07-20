import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'gender_toggle.dart';

class GenderTogglePill extends StatelessWidget {
  final String selectedGender;
  final ValueChanged<String> onChanged;

  const GenderTogglePill({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87),
        borderRadius: BorderRadius.circular(25.r),
        color: Colors.white,
      ),
      child: Row(
        children: [
          GenderIconToggleButton(
            icon: Icons.male,
            gender: 'Male',
            selectedGender: selectedGender,
            onTap: () => onChanged('Male'),
          ),
          GenderIconToggleButton(
            icon: Icons.female,
            gender: 'Female',
            selectedGender: selectedGender,
            onTap: () => onChanged('Female'),
          ),
        ],
      ),
    );
  }
}