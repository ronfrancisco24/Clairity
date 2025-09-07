import 'package:flutter/material.dart';

class SensorDropdown extends StatefulWidget {
  final List<String> list;
  final String value;
  final ValueChanged<String> onChanged;

  const SensorDropdown({
    super.key,
    required this.list,
    required this.value,
    required this.onChanged,
  });

  @override
  State<SensorDropdown> createState() => _SensorDropdownState();
}

class _SensorDropdownState extends State<SensorDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        value: widget.value,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        onChanged: (String? value) {
          if (value != null) {
            widget.onChanged(value);
          }
        },
        // Dropdown menu items (show names)
        items: widget.list.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value), // show full sensor name in menu
          );
        }).toList(),
        // Selected value display (show index instead)
        selectedItemBuilder: (BuildContext context) {
          return widget.list.asMap().entries.map<Widget>((entry) {
            final index = entry.key;
            return Align(
                alignment: Alignment.centerLeft,
                child: Text("Sensor ${index + 1}")); // show index in the button
          }).toList();
        },
      ),
    );
  }
}
