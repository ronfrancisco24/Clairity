import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../models/cleaning_log_model.dart';
import '../providers/log_provider.dart';
import '../providers/sensor_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/navbar/navbar.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/history/history_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/databases/databases_screen.dart';
import '../constants.dart' as constants;

class NavController extends StatefulWidget {
  const NavController({super.key});

  @override
  State<NavController> createState() => _NavControllerState();

  static _NavControllerState? of(BuildContext context) {
    return context.findAncestorStateOfType<_NavControllerState>();
  }

}

class _NavControllerState extends State<NavController> {
  constants.NavRoute _activeRoute = constants.NavRoute.home;
  int _historyIndex = 1;

  Widget _getScreen(constants.NavRoute route, String role) {
    switch (route) {
      case constants.NavRoute.home:
        return const DashboardScreen();
      case constants.NavRoute.history:
        return role == 'admin'
            ? DatabasesScreen(initialIndex: _historyIndex)
            : HistoryScreen(initialIndex: _historyIndex);
      case constants.NavRoute.profile:
        return const ProfileScreen();
    }
  }

  void onNavSelect(constants.NavRoute route, {int? initialIndex}) {
    setState(() {
      _activeRoute = route;
      if (route == constants.NavRoute.history) {
        _historyIndex = initialIndex ?? 1; // 👈 fallback to 1
      }
    });
  }

  Future<void> _addQuickRecord(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final logProvider = Provider.of<LogProvider>(context, listen: false);
    final sensorProvider = Provider.of<SensorProvider>(context, listen: false);

    // Get the currently selected sensorId from the provider
    final sensorId = sensorProvider.sensorId;

    if (sensorId == null || sensorId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No active sensor selected.')),
      );
      return;
    }

    final newRecord = CleaningRecord(
      cleaningId: '',
      sensorId: sensorId,
      userId: userProvider.user?.uid ?? '',
      comment: 'Cleaned.',
      rating: 5,
      timestamp: DateTime.now().toUtc().add(const Duration(hours: 8)),
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
              onSelect: onNavSelect,
              role: role,
              onAddRecord: () => _addQuickRecord(context),
            ),
          ),
        ],
      ),
    );
  }
}
