import 'package:flutter/material.dart';
import 'feature_list.dart';
import 'footer.dart';
import 'frosted_container.dart';
import 'header.dart';
import '../../../constants.dart';

class HelpPopup extends StatelessWidget {
  const HelpPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    final rolesList = buildFeatureSection(
      sectionTitle: 'User Roles',
      features: const [
        FeatureItem(
            label: 'Janitor',
            description:
                'Gets alerts, views restroom status, marks as cleaned.'),
        FeatureItem(
            label: 'Admin',
            description: 'Manages users, sensors, and system settings'),
      ],
    );

    final infoList = buildFeatureSection(
      sectionTitle: 'How it Works',
      features: const [
        FeatureItem(
            label: '📡 Air Quality Monitoring',
            description:
                'Tracks air quality and pollutants like ammonia, VOCs, and more.'),
        FeatureItem(
            label: '🔔 Smart Alerts',
            description: 'Notifies janitors when air quality drops.'),
        FeatureItem(
            label: '✅ Mark as Cleaned',
            description: 'Janitors confirm cleaning to reset the alert.'),
        FeatureItem(
            label: '📈 Admin Controls',
            description: 'Admins view data trends and manage thresholds.'),
      ],
    );

    final tipsList = buildFeatureSection(
      sectionTitle: 'Quick Tips',
      features: const [
        FeatureItem(
            label: '🔔 Enable Notifications',
            description: 'Ensure alerts are turned on in device settings.'),
        FeatureItem(
            label: '🕓 Check Dashboard Regularly',
            description:
                'Keep an eye on real-time status for sudden changes in air quality.'),
        FeatureItem(
            label: '📅 Review Hourly Trends',
            description:
                'Use history logs to identify restrooms needing more frequent cleaning.'),
      ],
    );

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: width * 0.99,
        height: height * 0.7,
        decoration: BoxDecoration(
          gradient: AppGradients.secondaryGradient,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Header(title: 'Help - Clairity Guide'),
              const SizedBox(height: 5),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(height: 20),
                      ...rolesList,
                      const Divider(height: 20),
                      ...infoList,
                      const Divider(height: 20),
                      Text(
                        'Alerts',
                        style: kTitleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: vividGreen,
                        ),
                      ),
                      SizedBox(height: 10,),
                      FrostedContainer(
                          width: width * 0.9,
                          height: height * 0.05,
                          text: 'Red - Needs immediate cleaning.',
                          color: Colors.red),
                      SizedBox(
                        height: 20,
                      ),
                      FrostedContainer(
                          width: width * 0.9,
                          height: height * 0.05,
                          text: 'Yellow - Moderate, check soon',
                          color: Colors.yellowAccent),
                      SizedBox(
                        height: 10,
                      ),
                      const Divider(height: 20),
                      ...tipsList,
                    ],
                  ),
                ),
              ),
              Footer(width: width, height: height),
            ],
          ),
        ),
      ),
    );
  }
}
