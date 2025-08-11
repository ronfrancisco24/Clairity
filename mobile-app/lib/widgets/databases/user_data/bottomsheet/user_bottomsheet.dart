import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../models/user_model.dart';
import '../../../../providers/user_provider.dart';
import 'action_confirmation.dart';
import 'action_type.dart';
import 'info_container/info_container.dart';

void showUserBottomSheet(BuildContext context, UserModel user) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      ActionType currentAction = ActionType.none;
      Map<String, dynamic> updatedData = {};

      return StatefulBuilder(
        builder: (context, setState) {
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r),),
                border: const Border(
                  top: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20.h,
                  left: 40.w,
                  right: 40.w,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 5.h,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    InfoContainer(
                      user: user,
                      onActionSelected: (action) {
                        setState(() {
                          currentAction = action;
                        });
                      },
                      currentAction: currentAction,
                      onEditDataChanged: (data) {
                        updatedData = data;
                      },
                    ),
                    SizedBox(height: 20.h),
                    ActionConfirmation(
                      controller: TextEditingController(),
                      actionType: currentAction,
                      onConfirm: () async {
                        final userProvider = Provider.of<UserProvider>(context, listen: false);

                        if (currentAction == ActionType.delete) {
                          await userProvider.deleteUser(user.uid);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('User deleted successfully')),
                          );
                        } else if (currentAction == ActionType.edit) {
                          await userProvider.editUser(user.uid, updatedData);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('User updated successfully')),
                          );
                        }

                        Navigator.pop(context);
                      },
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}