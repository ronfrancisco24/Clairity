import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../screens/notifications/notifications_screen.dart';


class NotificationsButton extends StatelessWidget {
  final bool readNotfications; //TODO: implement logic when notifications is detected (use state management tool for this)

  const NotificationsButton({super.key, this.readNotfications = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationScreen()),
        );
      },
      child: Stack(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: CupertinoColors.black,
            ),
          ),
          const Positioned(
            left: 8,
            top: 6,
            child: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
          readNotfications ? Positioned(
            left: 28,
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
            ),
          ) : const SizedBox.shrink()
        ],
      ),
    );
  }
}
