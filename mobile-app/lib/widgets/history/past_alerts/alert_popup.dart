import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../utils/alert_utils.dart';

class AlertPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: context.screenHeight * 0.8,
        height: context.screenWidth * 1.3,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Very High Gas Levels Detected!'),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [Icon(Icons.access_time_outlined), Text('Time')],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined),
                      Text('Sensor')
                    ],
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                color: Colors.grey,
                child: const Column(
                  children: [
                    Text('Description'),
                    Text('This is a message.')
                  ],
                ),
              ),
              const Text('Current Readings'),
              Container(
                width: double.infinity,
                color: Colors.grey,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text('130'),
                        Text('AQI'),
                      ],
                    ),
                    Column(
                      children: [
                        Text('50 ppm'),
                        Text('VOC ppm (Threshold: 400 ppm)'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
