import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dashboard_card.dart';
import 'user_table.dart';
import 'search_bar.dart';

class UserDataTab extends StatefulWidget {
  const UserDataTab({super.key});

  @override
  State<UserDataTab> createState() => _UserDataTabState();
}

class _UserDataTabState extends State<UserDataTab> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  final List<Map<String, dynamic>> _users = [
    {
      'name': 'Edward Cullen',
      'username': 'no-dan_staff',
      'phoneNo': '09XX-XXXX-XXX',
      'assignedBuilding': 'FOH',
      'submittedLogs': 3,
      'status': 'online',
    },
    {
      'name': 'Jane Smith',
      'username': 'jane_maintenance',
      'phoneNo': '09XX-XXXX-XXX',
      'assignedBuilding': 'Building A',
      'submittedLogs': 7,
      'status': 'offline',
    },
    {
      'name': 'Mike Johnson',
      'username': 'mike_janitor',
      'phoneNo': '09XX-XXXX-XXX',
      'assignedBuilding': 'Building B',
      'submittedLogs': 2,
      'status': 'offline',
    },
    {
      'name': 'Jane Doe',
      'username': 'bob_thebuilder',
      'phoneNo': '09XX-XXXX-XXX',
      'assignedBuilding': 'Building D',
      'submittedLogs': 2,
      'status': 'offline',
    },
    {
      'name': 'Jane Doe',
      'username': 'bob_thebuilder',
      'phoneNo': '09XX-XXXX-XXX',
      'assignedBuilding': 'Building D',
      'submittedLogs': 2,
      'status': 'offline',
    },
  ];

  List<Map<String, dynamic>> get filteredUsers {
    if (searchQuery.isEmpty) return _users;
    return _users.where((user) {
      return user.values.any((value) =>
          value.toString().toLowerCase().contains(searchQuery.toLowerCase()));
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, MediaQuery.of(context).padding.bottom + 100.h),
      child: Column(
        children: [
          DashboardCard(users: _users),
          SearchBarWidget(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            onClear: () {
              _searchController.clear();
              setState(() {
                searchQuery = '';
              });
            },
          ),
          SizedBox(height: 20),
          Expanded(child: UserTable(users: filteredUsers)),
        ],
      ),
    );
  }
}
