import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DatabaseTabSelector extends StatelessWidget {
  final int selectedIndex;
  final List<String> tabTitles;
  final ValueChanged<int> onTabSelected;

  const DatabaseTabSelector({
    super.key,
    required this.selectedIndex,
    required this.tabTitles,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: tabTitles.length,
        separatorBuilder: (_, __) => SizedBox(width: 15.w),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onTabSelected(index),
            child: SizedBox(
              width: 100.w, // fixed yet responsive width
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black87 : Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: Colors.black87),
                ),
                child: Center(
                  child: Text(
                    tabTitles[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
