import 'package:flutter/material.dart';

class CardLocation extends StatefulWidget {
  const CardLocation({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.sensors,
    required this.onSensorPicked,
  });

  final String imageUrl;
  final String title;
  final String subtitle;
  final List<String> sensors;
  final ValueChanged<String> onSensorPicked;

  @override
  State<CardLocation> createState() => _CardLocationState();
}

class _CardLocationState extends State<CardLocation> {


  Future<void> _pickSensor(BuildContext context) async {
    print('i was tapped');
    if (widget.sensors.isEmpty) return;

    final picked = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select a sensor'),
        children: [
          SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                children: widget.sensors.asMap().entries.map((entry) {
                  final index = entry.key;
                  final sensor = entry.value;
                  return SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, sensor);
                    },
                    child: Text('Sensor ${index + 1}: $sensor'),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );

    if (picked != null) {
      widget.onSensorPicked(picked); // ✅ notify DashboardScreen
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickSensor(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(18),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Image.network(
                widget.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  color: Colors.white.withOpacity(0.85),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}