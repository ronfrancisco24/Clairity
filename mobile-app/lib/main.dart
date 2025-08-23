import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'firebase_options.dart';
import 'providers/notification_provider.dart';
import 'providers/sensor_provider.dart';
import 'providers/user_provider.dart';
import 'screens/onboarding/splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/log_provider.dart';
import 'services/notification_reading_service.dart';
import 'utils/navbar_utils.dart';
import 'services/sensor_reading_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LogProvider()),
        ChangeNotifierProvider(create: (_) => SensorProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider())
      ],
      child: const MyApp(),
    ),
  );
}

// initialize sensor data throughout the app.


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // base size for scaling
      minTextAdapt: true,
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
