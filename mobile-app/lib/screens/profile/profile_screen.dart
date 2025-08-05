import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../widgets/profile/profile_container.dart';
import '../../widgets/profile/settings_tile.dart';
import '../../widgets/profile/popups/help_popup.dart';
import '../../widgets/profile/popups/about_popup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/sensor/notifications_button.dart';
import '../onboarding/splash_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profile',
                    style: kHeadlineMedium.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 30.sp),
                  ),
                  NotificationsButton()
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ProfileContainer(
                name: 'Kyle Mariano',
                email: 'kyle@hau.staff.com',
                building: 'PGN',
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Settings',
                style: kHeadlineMedium.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 20.sp),
              ),
              SettingsTile(
                tileTitle: 'Notifications',
                isToggle: true,
                iconContainerColor: forestGreen,
                icon: Icons.notifications_none,
                // TODO: toggle notifications once switch is on.
              ),
              SettingsTile(
                tileTitle: 'Help',
                isToggle: false,
                iconContainerColor: mossGreen,
                icon: Icons.help_outline,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => HelpPopup(),
                  );
                },
              ),
              SettingsTile(
                tileTitle: 'About',
                isToggle: false,
                iconContainerColor: oliveGreen,
                icon: Icons.info_outline_rounded,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AboutPopup(),
                  );
                },
              ),
              SettingsTile(
                //TODO: implement logout functionality.
                tileTitle: 'Logout',
                isToggle: false,
                iconContainerColor: Colors.red,
                icon: Icons.logout,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SplashScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
