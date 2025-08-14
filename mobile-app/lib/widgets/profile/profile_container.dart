import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart' as constants;

class ProfileContainer extends StatelessWidget {
  final String name;
  final String email;
  final String building;
  final int avatarIndex;
  final VoidCallback onAvatarTap;

  const ProfileContainer({
    required this.name,
    required this.email,
    required this.building,
    required this.avatarIndex,
    required this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        gradient: constants.AppGradients.primaryGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SizedBox(width: 40.w),
          GestureDetector(
            onTap: onAvatarTap,
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.1,
              backgroundImage: AssetImage(constants.avatarImage[avatarIndex]),
            ),
          ),
          SizedBox(width: 40.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: constants.kTitleMedium.copyWith(color: Colors.white)),
              Text(email, style: constants.kTitleSmall.copyWith(color: Colors.white)),
              Text(building, style: constants.kTitleSmall.copyWith(color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }
}