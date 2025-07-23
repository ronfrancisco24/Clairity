import 'package:flutter/material.dart';
import '../../../constants.dart';

class ListItem extends StatelessWidget {
  final String label;
  final String description;

  const ListItem({
    required this.label,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    text: '$label\n',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: greenAccent,
                      height: 2,
                    ),
                  ),
                  TextSpan(
                    text: description,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
