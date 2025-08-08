import 'package:flutter/material.dart';
import '../../constants.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({
    super.key,
    required this.activeRoute,
    required this.onSelect,
  });

  final NavRoute activeRoute;
  final void Function(NavRoute) onSelect;

  @override
  Widget build(BuildContext context) {
    const double navBarHeight = 64; // Adjust for your preferred pill height
    const double horizontalMargin = 24;

    return Container(
      height: navBarHeight,
      margin: const EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(navBarHeight / 2), // pill shape
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavigationItem(
            label: 'Home',
            iconData: Icons.home_outlined,
            isSelected: (activeRoute == NavRoute.home),
            onSelect: () => onSelect(NavRoute.home),
          ),
          NavigationItem(
            label: 'Sensor',
            iconData: Icons.wifi, // Use sensor door icon for demo
            isSelected: (activeRoute == NavRoute.sensor),
            onSelect: () => onSelect(NavRoute.sensor),
            spotlight: true, // Custom property for spotlight effect
          ),
          NavigationItem(
            label: 'History',
            iconData: Icons.history,
            isSelected: (activeRoute == NavRoute.history),
            onSelect: () => onSelect(NavRoute.history),
          ),
          NavigationItem(
            label: 'Profile',
            iconData: Icons.person_outline,
            isSelected: (activeRoute == NavRoute.profile),
            onSelect: () => onSelect(NavRoute.profile),
          ),
        ],
      ),
    );
  }
}

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    super.key,
    required this.iconData,
    required this.label,
    required this.isSelected,
    required this.onSelect,
    this.spotlight = false,
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
                  // Optionally hide label for a cleaner look
                  // Text(
                  //   label,
                  //   style: kBodyMedium.copyWith(
                  //     color: isSelected ? Colors.redAccent : Colors.white70,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}