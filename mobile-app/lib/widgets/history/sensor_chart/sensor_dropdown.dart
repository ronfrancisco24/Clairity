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
        items: widget.list.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value == widget.value ? "Current Sensor: $value" : value,
            ),
          );
        }).toList(),
      ),
    );
  }
}
