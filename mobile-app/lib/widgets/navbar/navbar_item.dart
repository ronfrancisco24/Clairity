import 'package:flutter/material.dart';
import '../../constants.dart';

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    super.key,
    required this.iconData,
    required this.label,
    required this.isSelected,
    required this.onSelect,
    this.spotlight = true,
  });

  final IconData iconData;
  final String label;
  final bool isSelected;
  final VoidCallback onSelect;
  final bool spotlight;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onSelect,
        child: SizedBox(
          height: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Spotlight effect
              if (isSelected && spotlight)
                Positioned(
                  top: 0,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          greenAccent.withOpacity(0.3),
                          Colors.transparent,
                        ],
                        radius: 0.8,
                      ),
                    ),
                  ),
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isSelected)
                    Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      width: 24,
                      height: 4,
                      decoration: BoxDecoration(
                        color: greenAccent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  Icon(
                    iconData,
                    color: isSelected ? greenAccent : Colors.white70,
                    size: isSelected ? 30 : 26,
                    shadows: isSelected
                        ? [
                      Shadow(
                        color: greenAccent.withOpacity(0.5),
                        blurRadius: 16,
                      ),
                    ]
                        : [],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}