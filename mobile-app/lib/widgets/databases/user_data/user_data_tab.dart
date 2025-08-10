import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import 'add/add_button.dart';
import 'add/add_user_dialog.dart';
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return StreamBuilder(
      stream: userProvider.nonAdminUsersStream,
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No users found'));
        }

        final users = snapshot.data!;

        final filteredUsers = searchQuery.isEmpty
            ? users
            : users.where((user) {
          final query = searchQuery.toLowerCase();
          return user.firstName.toLowerCase().contains(query) ||
              user.lastName.toLowerCase().contains(query) ||
              user.username.toLowerCase().contains(query) ||
              user.phoneNo.toLowerCase().contains(query) ||
              (user.building?.toLowerCase().contains(query) ?? false);
        }).toList();

        return Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, MediaQuery.of(context).padding.bottom + 100.h),
          child: Column(
            children: [
              DashboardCard(users: users),
              Row(
                children: [
                  Flexible(
                    child: SearchBarWidget(
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
                  ),
                  AddButton(
                    onAdd: () {
                      showDialog(
                        context: context,
                        builder: (_) => AddUserDialog(),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(child: UserTable(users: filteredUsers)),
            ],
          ),
        );
      }
    );
  }
}
