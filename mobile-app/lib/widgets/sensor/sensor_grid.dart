import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'sensor_card.dart';

class SensorGridWidget extends StatelessWidget {
  final List<SensorCard> sensorData; // Now accepts data as a parameter

  const SensorGridWidget({
    super.key,
    required this.sensorData, // Make data required
  });

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 12.h,
      children: List.generate(sensorData.length, (index) {
        final isOddCount = sensorData.length % 2 != 0;
        final isLastItem = index == sensorData.length - 1;
        final isDivisibleBy4 = sensorData.length % 4 == 0;

        // If it's the last item and the total count is odd, make it span both columns
        if (isLastItem && isOddCount) {
          return StaggeredGridTile.fit(
            crossAxisCellCount: 2,
            child: SizedBox(
              height: 135.h,
              child: sensorData[index],
            ),
          );
        } else {
          double itemHeight;

          if (isDivisibleBy4) {
            itemHeight = ((index % 2) == 0) ? 160.h : 120.h;
          } else {
            if (!isOddCount && (isLastItem || index == sensorData.length - 2)) {
              itemHeight = 140.h;
            } else if (sensorData.length < 4 && isOddCount && (index == sensorData.length - 3 || index == sensorData.length - 2)) {
              itemHeight = 140.h;
            } else {
              itemHeight = ((index % 2) == 0) ? 160.h : 120.h;
            }
          }

          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: SizedBox(
              height: itemHeight,
              child: sensorData[index],
            ),
          );
        }
      }),
    );
  }
}