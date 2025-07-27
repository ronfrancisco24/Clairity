import 'package:flutter/material.dart';

class Ratings extends StatefulWidget {
  final Color color;
  final int initialRating;
  final ValueChanged<int> onRatingSelected;

  const Ratings({
    super.key,
    required this.color,
    required this.onRatingSelected,
    required this.initialRating,
  });

  @override
  State<Ratings> createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  late int _selectedRating;

  @override
  void initState() {
    super.initState();
    _selectedRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedRating = index + 1;
            });
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