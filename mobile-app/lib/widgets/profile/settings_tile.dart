import 'package:flutter/material.dart';

import '../../constants.dart';

class SettingsTile extends StatefulWidget {
  final String tileTitle;
  final bool isToggle;
  final Color iconContainerColor;
  final IconData icon;
  final VoidCallback? onTap;
  final Function(bool)? onToggle; // <-- change here

  SettingsTile({
    super.key,
    required this.tileTitle,
    required this.isToggle,
    required this.iconContainerColor,
    required this.icon,
    this.onTap,
    this.onToggle,
  });

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  bool toggleValue = false;

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
                color: widget.iconContainerColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                widget.icon,
                color: Colors.white,
              ),
            ),
            title: Text(widget.tileTitle),
            trailing: widget.isToggle
                ? Switch(
                    value: toggleValue,
                    activeColor: mossGreen,
                    onChanged: (bool newValue) {
                      setState(() {
                        toggleValue = newValue;
                      });
                      if (widget.onToggle != null) {
                        widget.onToggle!(newValue); // <-- pass new value
                      }
                    }
                  )
                : const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    );

    // Only wrap with GestureDetector if isToggle is false
    return widget.isToggle
        ? tile
        : GestureDetector(
      onTap: () {
        if (widget.onToggle != null) widget.onToggle!(true);
      },
      child: tile,
    );
  }
}
