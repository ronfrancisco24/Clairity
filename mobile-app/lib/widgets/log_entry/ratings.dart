import 'package:flutter/material.dart';

class Ratings extends StatefulWidget {
  final Color color;
  final ValueChanged<int> onRatingSelected;

  const Ratings(
      {super.key, required this.color, required this.onRatingSelected});

  @override
  State<Ratings> createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedRating = index + 1;
            });
            // passes the selectedRating value back to the parent.
            widget.onRatingSelected(_selectedRating);
          },
          child: Icon(
            index < _selectedRating ? Icons.star : Icons.star_border,
            color: widget.color,
            size: MediaQuery.sizeOf(context).width * 0.09,
          ),
        );
      }),
    );
  }
}
