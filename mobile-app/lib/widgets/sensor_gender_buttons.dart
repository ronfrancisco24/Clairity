import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderButtonWidget extends StatelessWidget {
  final String selectedGender;
  final ValueChanged<String> onGenderSelected;

  const GenderButtonWidget({
    Key? key,
    required this.selectedGender,
    required this.onGenderSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Male button
        GestureDetector(
          onTap: () => onGenderSelected('male'),
          child: Text(
            "MALE",
            style: TextStyle(
              fontWeight: selectedGender == 'male' ? FontWeight.bold : FontWeight.normal,
              fontSize: 18.sp,
              color: selectedGender == 'male' ? Colors.black : Colors.grey,
            ),
          ),
        ),
        SizedBox(width: 40.w),
        // Female button
        GestureDetector(
          onTap: () => onGenderSelected('female'),
          child: Text(
            "FEMALE",
            style: TextStyle(
              fontWeight: selectedGender == 'female' ? FontWeight.bold : FontWeight.normal,
              fontSize: 18.sp,
              color: selectedGender == 'female' ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}