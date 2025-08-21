import 'package:flutter/material.dart';

import '../../services/sensor_reading_service.dart';

enum BathroomType { women, men }

class CardLocation extends StatefulWidget {
  const CardLocation({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  final String imageUrl;
  final String title;
  final String subtitle;

  @override
  State<CardLocation> createState() => _CardLocationState();
}

class _CardLocationState extends State<CardLocation> {
  BathroomType _selectedBathroom = BathroomType.women;
  final _service = SensorReadingService();
  List<String> _sensorIds = [];
  String? _selectedSensorId;
  bool _loading = false;


  //TODO: show sensors here.
  Future<void> _pickSensor() async {
    setState(() => _loading = true);

    // Fetch the sensor IDs
    final sensors = await _service.fetchAllSensorIds();

    setState(() {
      _sensorIds = sensors;
      _loading = false;
    });

    // Show dialog only if there are sensors
    if (_sensorIds.isEmpty) return;

    final picked = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select a sensor'),
        children: [
          SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                children: _sensorIds.asMap().entries.map((entry) {
                  final index = entry.key;
                  final id = entry.value;
                  return SimpleDialogOption(
                    onPressed: () {
                      print('Selected index: $index');
                      Navigator.pop(context, id);
                    },
                    child: Text('Sensor ${index + 1} - id: $id'),
                  );
                }).toList(),
              ),
            ),
          )
        ]
      ),
    );

    if (picked != null) {
      setState(() {
        _selectedSensorId = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickSensor,
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