import 'package:flutter/material.dart';
import '../widgets/navbar/navbar.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/sensor/sensor_screen.dart';
import '../screens/history/history_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../constants.dart' as constants;

class NavController extends StatefulWidget {
  const NavController({super.key});

  @override
  State<NavController> createState() => _NavControllerState();
}

class _NavControllerState extends State<NavController> {
  constants.NavRoute _activeRoute = constants.NavRoute.home;

  Widget _getScreen(constants.NavRoute route) {
    switch (route) {
      case constants.NavRoute.home:
        return const DashboardScreen();
      case constants.NavRoute.sensor:
        return const SensorScreen();
      case constants.NavRoute.history:
        return const HistoryScreen();
      case constants.NavRoute.profile:
        return const ProfileScreen();
    }
  }

  void _onNavSelect(constants.NavRoute route) {
    setState(() {
      _activeRoute = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    const double bottomOffset = 50.0;

    return Scaffold(
      body: Stack(
        children: [
          _getScreen(_activeRoute),
          Positioned(
            left: 24,
            right: 24,
            bottom: bottomOffset,
            child: MainNavigationBar(
              activeRoute: _activeRoute,
              onSelect: _onNavSelect,
            ),
          ),
        ],
      ),
    );
  }
}