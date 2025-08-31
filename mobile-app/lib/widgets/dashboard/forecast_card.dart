import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utils/dashboard_utils.dart';

class ForecastCard extends StatelessWidget {
  const ForecastCard({super.key, required this.category, required this.value});

  final String? category;
  final double? value;

  Color getCategoricalColors(String? category) {
    switch (category) {
      case "Good":
        return Colors.green;
      case "Moderate":
        return Colors.blue;
      case "High":
        return Colors.orange;
      case "Very High":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final min60 = DateTime.now().toUtc().add(const Duration(hours: 9));
    late final String formatted60 = getFormattedTime(min60);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: getCategoricalColors(category).withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: getCategoricalColors(category),
              style: BorderStyle.solid,
              width: 2)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Next Forecast: $formatted60', style: aqiCardFont),
              const Text('AQI', style: aqiCardFont)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                  color: getCategoricalColors(category),
                  border: Border.all(
                    color: getCategoricalColors(category).withOpacity(0.7),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(category ?? "Unknown", style: aqiCardFont),
              ),
              Text('$value', style: aqiCardFont),
            ],
          ),
        ],
      ),
    );
  }
}
