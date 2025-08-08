import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bottomsheet/user_bottomsheet.dart';

class UserTable extends StatelessWidget {
  final List<Map<String, dynamic>> users;

  const UserTable({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return Center(child: Text('No users found.'));
    }

    final columns = users.first.keys.toList();

    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            showCheckboxColumn: false,
            headingRowColor: WidgetStateProperty.all(Colors.grey[200]),
            columnSpacing: 20.w,
            columns: columns
                .map((key) => DataColumn(label: Text(_beautifyHeader(key))))
                .toList(),
            rows: users.map((user) {
              return DataRow(
                onSelectChanged: (_) {
                  showUserBottomSheet(context, user);
                },
                cells: columns
                    .map((key) => DataCell(Text(user[key].toString())))
                    .toList(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  String _beautifyHeader(String key) {
    return key
        .replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (match) {
      return '${match.group(1)} ${match.group(2)}';
    })
        .replaceAll('_', ' ')
        .toUpperCase();
  }
}