import 'package:flutter/material.dart';

enum BathroomType { women, men }

class CardLocation extends StatefulWidget {
  const CardLocation({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  final String imageUrl;
  final String title;
  final String subtitle;

  @override
  State<CardLocation> createState() => _CardLocationState();
}

class _CardLocationState extends State<CardLocation> {
  BathroomType _selectedBathroom = BathroomType.women;

  Icon get _bathroomIcon {
    switch (_selectedBathroom) {
      case BathroomType.women:
        return const Icon(Icons.woman, color: Colors.red, size: 20);
      case BathroomType.men:
        return const Icon(Icons.man, color: Colors.blue, size: 20);
    }
  }

  Future<void> _pickBathroom() async {
    final picked = await showDialog<BathroomType>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Which bathroom to clean?'),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, BathroomType.women),
            child: Row(
              children: const [
                Icon(Icons.woman, color: Colors.red, size: 20),
                SizedBox(width: 8),
                Text('Women'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, BathroomType.men),
            child: Row(
              children: const [
                Icon(Icons.man, color: Colors.blue, size: 20),
                SizedBox(width: 8),
                Text('Men'),
              ],
            ),
          ),
        ],
      ),
    );
    if (picked != null) {
      setState(() {
        _selectedBathroom = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickBathroom,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(18),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Image.network(
                widget.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  color: Colors.white.withOpacity(0.85),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 6),
                          _bathroomIcon,
                        ],
                      ),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}