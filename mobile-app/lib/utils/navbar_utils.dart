import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../models/cleaning_log_model.dart';
import '../providers/log_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/navbar/navbar.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/sensor/sensor_screen.dart';
import '../screens/history/history_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/databases/databases_screen.dart';
import '../constants.dart' as constants;

class NavController extends StatefulWidget {
  const NavController({super.key});

  @override
  State<NavController> createState() => _NavControllerState();
}

class _NavControllerState extends State<NavController> {
  constants.NavRoute _activeRoute = constants.NavRoute.home;

  Widget _getScreen(constants.NavRoute route, String role) {
    switch (route) {
      case constants.NavRoute.home:
        return const DashboardScreen();
      case constants.NavRoute.sensor:
        return const SensorScreen();
      case constants.NavRoute.history:
        return  role == 'admin'
            ? const DatabasesScreen()
            : const HistoryScreen();
      case constants.NavRoute.profile:
        return const ProfileScreen();
    }
  }

  void _onNavSelect(constants.NavRoute route) {
    setState(() {
      _activeRoute = route;
    });
  }

  Future<void> _addQuickRecord(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final logProvider = Provider.of<LogProvider>(context, listen: false);

    final newRecord = CleaningRecord(
      cleaningId: '',
      sensorId: 'YDTdkdd2dSFsw6dtyvjd', // replace with actual sensor if needed
      userId: userProvider.user?.uid ?? '',
      comment: 'Cleaned.',
      rating: 5,
      timestamp: DateTime.now(),
      acknowledged: false,
      adminMessage: '',
    );

    await logProvider.addLog(newRecord);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cleaning record added.')),
    );

    setState(() {
      _activeRoute = constants.NavRoute.history;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final role = userProvider.user?.role ?? 'user';

    return Scaffold(
      body: Stack(
        children: [
          _getScreen(_activeRoute, role),
          Positioned(
            left: 24,
            right: 24,
            bottom: constants.bottomOffset.h,
            child: MainNavigationBar(
              activeRoute: _activeRoute,
              onSelect: _onNavSelect,
              role: role,
              onAddRecord: () => _addQuickRecord(context),
            ),
          ),
        ],
      ),
    );
  }
}
