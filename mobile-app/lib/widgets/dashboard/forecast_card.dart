import 'package:flutter/material.dart';

import '../../utils/dashboard_utils.dart';

class ForecastCard extends StatelessWidget {
  const ForecastCard(
      {super.key,
      required this.category,
      required this.value});

  final String? category;
  final double? value;

  Color getCategoricalColors(String? category) {
    switch (category) {
      case "Good":
        return Colors.green;
      case "Moderate":
        return Colors.blue;
      case "At Risk":
        return Colors.orange;
      case "Unhealthy":
        return Colors.red;
      case "Hazardous":
        return Color(0xFF7E0023);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final min60 = DateTime.now().toUtc().add(const Duration(hours: 9));
    late final String formatted60 = getFormattedTime(min60);

    return Container(
      padding: EdgeInsets.all(10),
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
              Text(
                'Next Forecast: ${formatted60}',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                'AQI',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
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
                child: Text(
                  category ?? "Unknown",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                '$value',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
