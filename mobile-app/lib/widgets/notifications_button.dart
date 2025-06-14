import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsButton extends StatelessWidget {
  const NotificationsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
          Positioned(
            left: 8,
            top: 6,
            child: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
          Positioned(
            left: 28,
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20)
              ),
            ),
          )
        ],
      ),
    );
  }
}
