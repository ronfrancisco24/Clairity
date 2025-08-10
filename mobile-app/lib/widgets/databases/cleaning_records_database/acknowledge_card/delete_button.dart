import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../delete_confirm_dialog.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteButton({
    super.key,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDeleteConfirmationDialog(context, onDelete),
      child: Container(
        width: 30.w,
        height: 30.w,
        decoration: BoxDecoration(
          color: Colors.red[400],
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 16.w,
        ),
      ),
    );
  }
}
