import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showDeleteConfirmationDialog(BuildContext context, VoidCallback onDelete) {
  final TextEditingController inputController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        title: Text(
          "Confirm Deletion",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Type 'delete' to confirm. This action cannot be undone.",
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: inputController,
              decoration: InputDecoration(
                hintText: "Type here...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel
            child: Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
            ),
            onPressed: () {
              if (inputController.text.trim().toLowerCase() == "delete") {
                Navigator.pop(context); // Close dialog
                onDelete(); // Execute deletion
              }
            },
            child: Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}