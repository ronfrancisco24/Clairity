import 'package:flutter/material.dart';

import '../../constants.dart';

class SettingsTile extends StatelessWidget {
  final String tileTitle;
  final bool isToggle;
  final Color iconContainerColor;
  final IconData icon;
  final VoidCallback? onTap;
  final Function(bool)? onToggle; // <-- change here
  bool toggleValue; // must be passed in constructor

  SettingsTile({
    super.key,
    required this.tileTitle,
    required this.isToggle,
    required this.iconContainerColor,
    required this.icon,
    this.onTap,
    this.onToggle,
    this.toggleValue = false
  });

  @override
  Widget build(BuildContext context) {
    Widget tile = SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Card(
        color: Colors.white,
        child: Center(
          child: ListTile(
            leading: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.11,
              decoration: BoxDecoration(
                color: iconContainerColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            title: Text(tileTitle),
            trailing: isToggle
                ? Switch(
                    value: toggleValue,
                    activeColor: mossGreen,
                    onChanged: (bool newValue) {
                      if (onToggle != null) {
                        onToggle!(newValue); // call parent callback
                      }
                    },
                  )
                : const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    );

    // Only wrap with GestureDetector if isToggle is false
    return isToggle
        ? tile
        : GestureDetector(
            onTap: onTap,
            child: tile,
          );
  }
}
