import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../models/user_model.dart';
import 'detail_row.dart';
import 'action_buttons.dart';
import '../action_type.dart';
import 'edit_text_field.dart';

class InfoContainer extends StatefulWidget {
  final UserModel user;
  final ActionType currentAction;
  final void Function(ActionType) onActionSelected;
  final void Function(Map<String, dynamic>) onEditDataChanged;

  const InfoContainer({
    Key? key,
    required this.user,
    required this.currentAction,
    required this.onActionSelected,
    required this.onEditDataChanged,
  }) : super(key: key);

  @override
  State<InfoContainer> createState() => _InfoContainerState();
}

class _InfoContainerState extends State<InfoContainer> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController usernameController;
  late TextEditingController buildingController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.user.firstName);
    lastNameController = TextEditingController(text: widget.user.lastName);
    usernameController = TextEditingController(text: widget.user.username);
    buildingController = TextEditingController(text: widget.user.building ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.currentAction == ActionType.edit;

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            isEditing
                ? Row(
                  children: [
                    Expanded(
                      child: EditTextField(
                        controller: firstNameController,
                        label: 'First Name',
                        onChanged: _updateData,
                      ),
                    ),
                    SizedBox(width: 4.w,),
                    Expanded(
                      child: EditTextField(
                        controller: lastNameController,
                        label: 'Last Name',
                        onChanged: _updateData,
                      ),
                    )
                  ],
                )
                : DetailRow(label: 'Name', value: widget.user.firstName + ' ' + widget.user.lastName),
            isEditing
                ? EditTextField(
                    controller: usernameController,
                    label: 'Username',
                    onChanged: _updateData,
                )
                : DetailRow(label: 'Username', value: widget.user.username),
            isEditing
                ? EditTextField(
                    controller: buildingController,
                    label: 'Building',
                    onChanged: _updateData,
                  )
                : DetailRow(label: 'Building', value: widget.user.building ?? ''),
            DetailRow(label: 'Phone', value: widget.user.phoneNo),
            DetailRow(label: 'Created At', value: widget.user.createdAt.toString()),

            ActionButtons(
              onDelete: () => widget.onActionSelected(ActionType.delete),
              onEdit: () => widget.onActionSelected(ActionType.edit),
            ),
          ],
        ),
      ),
    );
  }

  void _updateData() {
    widget.onEditDataChanged({
      'firstName': firstNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
      'username': usernameController.text.trim(),
      'building': buildingController.text.trim(),
    });
  }
}