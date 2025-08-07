import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../constants.dart' as constants;

class DashboardCard extends StatelessWidget {
  final List<Map<String, dynamic>> users;

  const DashboardCard({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    final buildingCounts = <String, int>{};

    for (var user in users) {
      final building = user['assignedBuilding'] ?? 'Unknown';
      buildingCounts[building] = (buildingCounts[building] ?? 0) + 1;
    }

    final totalUsers = users.length;
    final List<PieChartSectionData> sections = [];
    final List<_LegendItem> legendItems = [];


    int index = 0;
    buildingCounts.forEach((building, count) {
      final color = constants.legendColors[index % constants.legendColors.length];
      final percentage = (count / totalUsers) * 100;
      sections.add(
        PieChartSectionData(
          color: color,
          value: percentage,
          title: '${percentage.toStringAsFixed(1)}%',
          radius: 40.r,
          titleStyle: TextStyle(
            color: Colors.white,
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

      legendItems.add(_LegendItem(name: building, color: color, count: count));
      index++;
    });

    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      padding: EdgeInsets.all(16.w),
      width: double.infinity,
      height: 180.h,
      decoration: BoxDecoration(
        gradient: constants.AppGradients.adminGradient,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Staff Distribution by Assigned Building',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.white),
          ),
          const Spacer(),
          Row(
            children: [
              SizedBox(
                width: 120.w,
                height: 120.h,
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: 15.w,
                    sectionsSpace: 1,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Wrap(
                  spacing: 10.w,
                  runSpacing: 5.h,
                  children: legendItems.map((item) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 10.w,
                          height: 10.w,
                          color: item.color,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          '${item.name} (${item.count})', // ✅ Show building name with count
                          style: TextStyle(fontSize: 12.sp, color: Colors.white),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem {
  final String name;
  final Color color;
  final int count;

  _LegendItem({required this.name, required this.color, required this.count});
}
