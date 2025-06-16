import 'package:flutter/material.dart';


class AppFonts {
  static const String dmSans = 'DM Sans';
}
class AppColors {
  static const Color white = Color(0xFFF3F4F5);
  static const Color lightBlo = Color(0xFFA6BDBE);
  static const Color darkBlo = Color(0xFF0B334D);
  static const Color apricot = Color(0xFFF8B978);
  static const Color red = Color(0xFF65000B);
  static const Color darkRed = Color(0xFF3C1414);

  static const Color oliveGreen = Color(0xFF6E8649);
  static const Color mossGreen = Color(0xFF477023);
  static const Color forestGreen = Color(0xFF2D531A);
}
class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.53, 1.0],
    colors: [
      Color(0xFF2D531A), // Stop 0%
      Color(0xFF0B334D), // Stop 53%
      Color(0xFF18232A), // Stop 100%
    ],
  );
}
/*Container(
  decoration: const BoxDecoration(
    gradient: AppGradients.primaryGradient,
  ),
)
*/




// Example usage of the constants
/*Text(
  'Hello, world!',
  style: TextStyle(
    fontFamily: AppFonts.dmSans,
    color: AppColors.darkBlo,
  ),
);
*/
// Example usage of the colors
/*Container(
  color: AppColors.lightBlo,
  child: Text(
    'Welcome to the app!',
    style: TextStyle(color: AppColors.white),
  ),
);
*/
