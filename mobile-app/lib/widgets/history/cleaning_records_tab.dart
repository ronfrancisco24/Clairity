import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cleaner_tile.dart';

class CleaningRecordsTab extends StatelessWidget {
  const CleaningRecordsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.sp),
      children: const [
        CleanerTile(
          name: "Juan Dela Cruz",
          comment: "Standard task. Cleaned thoroughly.",
          stars: 5,
        ),
        CleanerTile(
          name: "Maria Clara",
          comment: "Basic cleaning. No bad odor encountered.",
          stars: 4,
        ),
        CleanerTile(
          name: "Jose Rizal",
          comment: "Wasn't able to ventilate the restroom well...",
          stars: 3,
        ),
      ],
    );
  }
}
