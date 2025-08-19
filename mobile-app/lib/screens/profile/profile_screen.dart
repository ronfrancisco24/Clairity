import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../providers/sensor_provider.dart';
import '../../widgets/profile/popups/avatar_selection_dialog.dart';
import '../../widgets/profile/profile_container.dart';
import '../../widgets/profile/settings_tile.dart';
import '../../widgets/profile/popups/help_popup.dart';
import '../../widgets/profile/popups/about_popup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/sensor/notifications/notifications_button.dart';
import '../onboarding/splash_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    // Load user data once when screen opens
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    final firstName = userProvider.user?.firstName ?? 'No name';
    final lastName = userProvider.user?.lastName ?? 'No name';
    final phoneNo = userProvider.user?.phoneNo ?? 'No number';

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
                name: '${firstName} ${lastName}',
                email: phoneNo,
                building: userProvider.user?.building ?? 'PGN',
                avatarIndex: userProvider.user?.avatar ?? 0,
                onAvatarTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AvatarSelectionDialog(
                      currentAvatarIndex: userProvider.user?.avatar,
                      onSave: (index) async {
                        await userProvider.changeAvatar(index);
                      },
                    ),
                  );
                },
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
                  SensorProvider().disposeListeners();
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
