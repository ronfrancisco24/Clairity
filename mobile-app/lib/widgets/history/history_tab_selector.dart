import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//TODO: Data based on gender of restroom

class HistoryTabSelector extends StatelessWidget {
  final int selectedIndex;
  final List<String> tabTitles;
  final ValueChanged<int> onTabSelected;

  const HistoryTabSelector({
    super.key,
    required this.selectedIndex,
    required this.tabTitles,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(tabTitles.length, (index) {
          final isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(index),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black87 : Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: Colors.black87),
                ),
                child: Center(
                  child: Text(
                    tabTitles[index],
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
        }),
      ),
    );
  }
}
