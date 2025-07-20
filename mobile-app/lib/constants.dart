import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum NavRoute {
  home,
  sensor,
  history,
  profile,
}

const Color white = Color(0xFFF3F4F5);
const Color lightBlo = Color(0xFFA6BDBE);
const Color darkBlo = Color(0xFF0B334D);
const Color apricot = Color(0xFFF8B978);
const Color red = Color(0xFF65000B);
const Color darkRed = Color(0xFF3C1414);

const Color oliveGreen = Color(0xFF6E8649);
const Color mossGreen = Color(0xFF477023);
const Color forestGreen = Color(0xFF2D531A);
const Color greenAccent = Color(0xFF37964E);
const double bottomOffset = 30.0;

class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.34, 1.0],
    colors: [
      Color(0xFF18232A), // Stop 0%
      Color(0xFF0B334D), // Stop 53%
      Color(0xFF2D531A), // Stop 100%
    ],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFF0B334D),
      Color(0xFF477023),
    ],
  );
}

class NavIcons {
  static const dashboard = 'material-symbols:home-rounded';
  static const sensor = 'material-symbols:sensors-rounded';
  static const create = Icons.add;
  static const history = 'material-symbols:history-2';
  static const profile = 'material-symbols:person-2-rounded';
}
/*Container(
  decoration: const BoxDecoration(
    gradient: AppGradients.primaryGradient,
  ),
)
*/

class AuthTheme {
  final ThemeData authTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    textTheme: GoogleFonts.dmSansTextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
  );
}

const TextStyle kTitle =
    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);

const TextStyle kHeading =
    TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white);

const TextStyle kSubheading = TextStyle(fontSize: 15, color: Colors.white);

TextStyle kDisplayLarge = GoogleFonts.dmSans(
  fontSize: 57,
  fontWeight: FontWeight.normal,
  letterSpacing: 0,
);

TextStyle kDisplayMedium = GoogleFonts.dmSans(
  fontSize: 45,
  fontWeight: FontWeight.normal,
  letterSpacing: 0,
);

TextStyle kDisplaySmall = GoogleFonts.dmSans(
  fontSize: 36,
  fontWeight: FontWeight.normal,
  letterSpacing: 0,
);

TextStyle kHeadlineLarge = GoogleFonts.dmSans(
  fontSize: 32,
  fontWeight: FontWeight.normal,
  letterSpacing: 0,
);

TextStyle kHeadlineMedium = GoogleFonts.dmSans(
  fontSize: 28,
  fontWeight: FontWeight.normal,
  letterSpacing: 0,
);

TextStyle kHeadlineSmall = GoogleFonts.dmSans(
  fontSize: 24,
  fontWeight: FontWeight.normal,
  letterSpacing: 0,
);

TextStyle kTitleLarge = GoogleFonts.dmSans(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  letterSpacing: 0,
);

TextStyle kTitleMedium = GoogleFonts.dmSans(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.15,
);

TextStyle kTitleSmall = GoogleFonts.dmSans(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.1,
);

TextStyle kLabelLarge = GoogleFonts.dmSans(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.1,
);

TextStyle kLabelMedium = GoogleFonts.dmSans(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
);

TextStyle kLabelSmall = GoogleFonts.dmSans(
  fontSize: 11,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
);

TextStyle kBodyLarge = GoogleFonts.dmSans(
  fontSize: 16,
  fontWeight: FontWeight.normal,
  letterSpacing: 0.5,
);

TextStyle kBodyMedium = GoogleFonts.dmSans(
  fontSize: 14,
  fontWeight: FontWeight.normal,
  letterSpacing: 0.25,
);

TextStyle kBodySmall = GoogleFonts.dmSans(
  fontSize: 12,
  fontWeight: FontWeight.normal,
  letterSpacing: 0.4,
);

TextStyle kNameTextStyle = GoogleFonts.dmSans(
  fontWeight: FontWeight.w700,
  fontSize: 18,
);
