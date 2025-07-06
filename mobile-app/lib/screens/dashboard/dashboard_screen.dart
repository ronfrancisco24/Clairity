import 'package:flutter/material.dart';
import '../../widgets/sensor/notifications_button.dart';

//TODO: configure mo nalang ung notifications button for void callbacks. e.g. navigation
//TODO: add metric cards: air quality, air quality/trends graph, air quality reminder, and pollutant card.

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Good Morning, John!',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text('Monday, June 1'),
                      ],
                    ),
                    NotificationsButton()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
