import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../providers/user_provider.dart';
import 'navbar_item.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({
    super.key,
    required this.activeRoute,
    required this.onSelect,
    required this.role,
    required this.onAddRecord,
  });

  final NavRoute activeRoute;
  final void Function(NavRoute) onSelect;
  final String role;
  final VoidCallback onAddRecord;

  @override
  Widget build(BuildContext context) {
    const double horizontalMargin = 24;
    final userProvider = Provider.of<UserProvider>(context);
    final role = userProvider.user?.role ?? 'user';

    return Container(
      height: navBarHeight.h,
      margin: const EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(navBarHeight.h / 2), // pill shape
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
          if (role == 'user') ...[
            NavigationItem(
              label: 'Add',
              iconData: Icons.add_circle_outline, // Use sensor door icon for demo
              isSelected: false,
              onSelect: onAddRecord,
            ),
          ],
          NavigationItem(
            label: role == 'admin' ? 'Database' : 'History',
            iconData: role == 'admin' ? Icons.storage : Icons.history,
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