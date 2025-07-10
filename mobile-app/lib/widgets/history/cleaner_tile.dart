import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CleanerTile extends StatelessWidget {
  final String name, comment;
  final int stars;

  const CleanerTile({
    super.key,
    required this.name,
    required this.comment,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(Icons.person)),
        title: Text(name, style: TextStyle(fontSize: 14.sp)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(comment, style: TextStyle(fontSize: 12.sp)),
            SizedBox(height: 4.h),
            Row(
              children: List.generate(
                5,
                    (index) => Icon(
                  index < stars ? Icons.star : Icons.star_border,
                  size: 14.sp,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
