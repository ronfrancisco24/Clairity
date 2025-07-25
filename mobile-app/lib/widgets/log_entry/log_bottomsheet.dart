import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../providers/log_provider.dart';
import '../../models/cleaning_log_model.dart';
import 'entry_button.dart';
import 'log_text_field.dart';
import 'ratings.dart';

class LogBottomsheet extends StatefulWidget {
  const LogBottomsheet({super.key});

  @override
  State<LogBottomsheet> createState() => _LogBottomsheetState();
}

class _LogBottomsheetState extends State<LogBottomsheet> {
  final TextEditingController _commentController = TextEditingController();
  int _selectedRating = 0;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Log Entry',
                  style: kHeadlineSmall.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                )
              ],
            ),
            Text('Rate Your Experience'),
            Ratings(
              color: Colors.yellow,
              onRatingSelected: (rating) {
                setState(() {
                  _selectedRating = rating;
                });
              },
            ),
            Text('Add a comment.'),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: LogTextField(
                    controller: _commentController,
                  )),
            ),
            Row(
              children: [
                EntryButton(
                  text: 'Cancel',
                  color: Colors.white,
                  onTap: () {},
                ),
                SizedBox(
                  width: 10,
                ),
                // Listens to see if text field has a value.
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _commentController,  // <-- Listens for changes in text
                  builder: (context, value, child) {
                    final hasText = value.text.isNotEmpty;
                    return EntryButton(
                      text: 'Save Log',
                      color: oliveGreen,
                      textColor: Colors.white,
                      hasText: hasText,
                      onTap: hasText
                          ? () {
                        final newLog = CleaningRecord(
                          cleaningId: DateTime.now().millisecondsSinceEpoch,
                          restroomId: 1,
                          userId: 1,
                          comment: _commentController.text,
                          rating: _selectedRating,
                          timestamp: DateTime.now(),
                        );

                        context.read<LogProvider>().addLog(newLog);
                        Navigator.pop(context);
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
