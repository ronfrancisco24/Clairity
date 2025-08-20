import 'package:flutter/material.dart';
import '../../utils/sensor_utils.dart';
import 'pollutant_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math';

class PollutantGrid extends StatelessWidget {
  final List<Map<String, dynamic>> pollutantList;
  final int crossAxisCount;

  const PollutantGrid({
    super.key,
    required this.pollutantList,
    this.crossAxisCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    final isOddCount = pollutantList.length % 2 != 0;

    return StaggeredGrid.count(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: pollutantList.asMap().entries.map((entry) {
        final index = entry.key;
        final data = entry.value;
        final isLastItem = index == pollutantList.length - 1;

        return StaggeredGridTile.fit(
          crossAxisCellCount: (isLastItem && isOddCount) ? crossAxisCount : 1,
          child: PollutantCard(
            // input firestore data
            value: data['value'],
            // take from pollutantMaxValues and assign its label.
            maxValue: (pollutantMaxValues[data['label']] ?? 100).toInt(),
            label: data['label'],
            progress: data['progress'],
          ),
        );
      }).toList(),
    );
  }
}
