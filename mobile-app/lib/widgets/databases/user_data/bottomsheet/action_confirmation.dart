import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'action_type.dart';

class ActionConfirmation extends StatefulWidget {
  final VoidCallback onConfirm;
  final TextEditingController controller;
  final ActionType actionType;

  const ActionConfirmation({
    super.key,
    required this.onConfirm,
    required this.controller,
    required this.actionType,
  });

  @override
  State<ActionConfirmation> createState() => _ActionConfirmationState();
}

class _ActionConfirmationState extends State<ActionConfirmation> {
  String _feedback = '';
  bool _inputCorrect = false;

  void _checkInput(String input) {
    final expected = widget.actionType == ActionType.delete
        ? 'delete'
        : widget.actionType == ActionType.edit
        ? 'edit'
        : '';

    setState(() {
      _inputCorrect = input.trim().toLowerCase() == expected;
      _feedback = ''; // clear feedback when typing
    });
  }

  void _handleConfirm() {
    final input = widget.controller.text.trim().toLowerCase();
    final expected = widget.actionType == ActionType.delete
        ? 'delete'
        : widget.actionType == ActionType.edit
        ? 'edit'
        : '';

    if (input == expected) {
      widget.onConfirm();
    } else {
      setState(() {
        _feedback = 'Incorrect input. Please type "$expected" to proceed.';
      });
    }
  }

  Color _getButtonColor() {
    if (widget.actionType == ActionType.none) {
      return Colors.grey[300]!;
    } else if (_inputCorrect) {
      return Colors.red;
    } else {
      return Colors.grey[300]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    String labelText = '';
    String instructionText = '';
    bool isDisabled = false;

    switch (widget.actionType) {
      case ActionType.none:
        instructionText = 'Select an Action to proceed';
        labelText = '';
        isDisabled = true;
        break;
      case ActionType.delete:
        instructionText = 'Type \'delete\' to confirm deletion of record';
        labelText = 'delete';
        break;
      case ActionType.edit:
        instructionText = 'Type \'edit\' to update the record';
        labelText = 'edit';
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          instructionText,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: isDisabled ? Colors.grey : Colors.black,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                onChanged: _checkInput,
                enabled: widget.actionType != ActionType.none,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  labelText: labelText.isNotEmpty
                      ? labelText
                      : null,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: isDisabled ? null : _handleConfirm,
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: _getButtonColor(),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16.w,
                ),
              ),
            ),
          ],
        ),
        if (_feedback.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Text(
            _feedback,
            style: TextStyle(color: Colors.red, fontSize: 12.sp),
          ),
        ],
      ],
    );
  }
}
