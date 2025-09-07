import 'dart:ui';
import 'package:flutter/material.dart';

class AlertUtils {
  Color getLevelColor(int level) {
    switch (level) {
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.orange; // Yellow
      case 3:
        return Colors.red; // Red
      case 4:
        return const Color(0xFF800000);
      default:
        return Colors.grey; // Default/fallback
    }
  }
}