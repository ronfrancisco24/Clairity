import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderDropdownIcon extends StatelessWidget {
  final String selectedGender;
  final ValueChanged<String?>? onChanged;

  const GenderDropdownIcon({
    Key? key,
    required this.selectedGender,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w, // Give it enough width to display icon + text
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedGender,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.grey,
          ),
          dropdownColor: Colors.white,
          selectedItemBuilder: (BuildContext context) {
            return ['Male', 'Female'].map((gender) {
              return Center(
                child: Icon(
                  gender == 'Male' ? Icons.male : Icons.female,
                  color: gender == 'Male' ? Colors.blue : Colors.pink,
                  size: 20.sp,
                ),
              );
            }).toList();
          },
          items: ['Male', 'Female'].map((gender) {
            final isMale = gender == 'Male';
            return DropdownMenuItem(
              value: gender,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isMale ? Icons.male : Icons.female,
                    color: isMale ? Colors.blue : Colors.pink,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    gender,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
