import 'package:flutter/material.dart';
import 'screens/notifications/notifications_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/sensor/sensor_screen.dart';
import 'screens/onboarding/sign_in_screen.dart';
import 'screens/onboarding/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // base size for scaling
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SensorScreen(),
        );
      },
    );
  }
}
