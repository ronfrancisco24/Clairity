import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'action_confirmation.dart';
import 'action_type.dart';
import 'info_container/info_container.dart';

void showUserBottomSheet(BuildContext context, Map<String, dynamic> user) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      ActionType currentAction = ActionType.none;

      return StatefulBuilder(
        builder: (context, setState) {
          return FractionallySizedBox(
            heightFactor: 0.6,
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
                    ),
                    SizedBox(height: 20.h),
                    ActionConfirmation(
                      controller: TextEditingController(),
                      actionType: currentAction,
                      onConfirm: () {
                        if (currentAction == ActionType.delete) {
                          print('Delete');

                          //Add Delete

                          Navigator.pop(context);
                        } else if (currentAction == ActionType.edit) {
                          print('Edit');

                          //Add edit

                          Navigator.pop(context);
                        }
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