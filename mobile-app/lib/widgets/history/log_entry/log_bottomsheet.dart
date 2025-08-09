import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../providers/log_provider.dart';
import '../../../models/cleaning_log_model.dart';
import '../../../providers/user_provider.dart';
import 'entry_button.dart';
import 'log_text_field.dart';
import 'ratings.dart';

class LogBottomsheet extends StatefulWidget {
  final CleaningRecord? recordToEdit;

  const LogBottomsheet({super.key, this.recordToEdit});

  @override
  State<LogBottomsheet> createState() => _LogBottomsheetState();
}

class _LogBottomsheetState extends State<LogBottomsheet> {
  final TextEditingController _commentController = TextEditingController();
  int _selectedRating = 0;

  @override
  void initState() {
    super.initState();
    if (widget.recordToEdit != null) {
      _commentController.text = widget.recordToEdit!.comment;
      _selectedRating = widget.recordToEdit!.rating;
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.recordToEdit != null;
    final userProvider = Provider.of<UserProvider>(context);
    final userID = userProvider.user?.uid ?? '';

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.5,
      width: MediaQuery.sizeOf(context).width * 1,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEdit ? 'Edit Log Entry' : 'Add Log Entry',
                  style: kHeadlineSmall.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            const Text('Rate Your Experience'),
            Ratings(
              color: Colors.yellow,
              initialRating: _selectedRating,
              onRatingSelected: (rating) {
                setState(() {
                  _selectedRating = rating;
                });
              },
            ),
            const Text('Add a comment.'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: LogTextField(
                  controller: _commentController,
                ),
              ),
            ),
            Row(
              children: [
                EntryButton(
                  text: 'Cancel',
                  color: Colors.white,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 10),
                // Listens to see if text field has a value.
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _commentController,
                  builder: (context, value, child) {
                    final hasText = value.text.isNotEmpty;
                    return EntryButton(
                      text: isEdit ? 'Update Log' : 'Save Log',
                      color: oliveGreen,
                      textColor: Colors.white,
                      hasText: hasText,
                      onTap: hasText
                          ? () async {
                        final logProvider = context.read<LogProvider>();

                        if (isEdit) {
                          final updatedLog = widget.recordToEdit!.copyWith(
                            comment: _commentController.text,
                            rating: _selectedRating,
                            timestamp: DateTime.now(),
                          );

                          await logProvider.editLog(updatedLog);
                        } else {
                          final newLog = CleaningRecord(
                            cleaningId: '',
                            sensorId: "1", // TODO: Fix sensor ID
                            userId: userID,
                            comment: _commentController.text,
                            rating: _selectedRating,
                            timestamp: DateTime.now(),
                            acknowledged: false,
                            adminMessage: '',
                          );

                          await logProvider.addLog(newLog);
                        }

                        if (mounted) Navigator.pop(context);
                      }
                          : null,
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}