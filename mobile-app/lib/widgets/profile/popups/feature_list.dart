// feature_list.dart
import 'package:flutter/material.dart';
import '../../../constants.dart'; // or wherever you store kTitleMedium, mossGreen
import 'list_item.dart'; // Adjust the path based on your folder structure

class FeatureItem {
  final String label;
  final String description;

  const FeatureItem({required this.label, required this.description});
}

List<Widget> buildFeatureSection({
  required String sectionTitle,
  required List<FeatureItem> features,
  TextStyle? titleStyle,
}) {
  return [
    Text(
      sectionTitle,
      style: titleStyle ??
          kTitleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: vividGreen,
          ),
    ),
    const SizedBox(height: 10),
    ...features.map(
          (item) => ListItem(
        label: item.label,
        description: item.description,
      ),
    ),
  ];
}
