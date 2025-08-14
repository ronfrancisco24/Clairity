import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants.dart' as constants;
import '../../databases/user_data/add/back_button.dart';
import 'update_avatar_button.dart';

class AvatarSelectionDialog extends StatefulWidget {
  final int? currentAvatarIndex;
  final ValueChanged<int> onSave;

  const AvatarSelectionDialog({
    required this.currentAvatarIndex,
    required this.onSave,
    super.key,
  });

  @override
  State<AvatarSelectionDialog> createState() => _AvatarSelectionDialogState();
}

class _AvatarSelectionDialogState extends State<AvatarSelectionDialog> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.currentAvatarIndex;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Your Avatar'),
      backgroundColor: Colors.white,
      content: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.33,
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              itemCount: constants.avatarImage.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
              ),
              itemBuilder: (context, index) {
                final isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.transparent,
                        width: 3,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(constants.avatarImage[index]),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 15.h,),
            Row(
              children: [
                BackButtonWidget(
                  onTap: () => Navigator.pop(context),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: UpdateAvatarButton(
                      onTap:  () {
                        if (selectedIndex != null) {
                          widget.onSave(selectedIndex!);
                          Navigator.pop(context);
                        }
                      },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}