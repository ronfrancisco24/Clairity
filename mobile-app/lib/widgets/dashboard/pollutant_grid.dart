import 'package:flutter/material.dart';
import '../../utils/dashboard_utils.dart';
import 'pollutant_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
            value:(data['value'] as num).toDouble(),
            // take from pollutantMaxValues and assign its label.
            maxValue: (pollutantMaxValues[data['label']] ?? 100).toInt(),
            label: '${_getLabelName(data['label'])} (${data['label']})',
            progress: data['progress'],
          ),
        );
      }).toList(),
    );
  }

  String _getLabelName (String label){
    switch (label) {
      case 'PM2.5':
        return 'Particulate Matter';
      case 'H₂S':
        return 'Hydrogen Sulfide';
      case 'NH₃':
        return 'Ammonia';
      case 'CO':
        return 'Carbon Monoxide';
      case 'CO₂':
        return 'Carbon Dioxide';
      case 'TVOC':
        return 'Total Volatile Organic Compounds';
      case 'CH₄':
        return 'Methane';
      default:
        return 'Pollutant';
    }
  }

}


