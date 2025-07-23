import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'footer.dart';
import 'feature_list.dart';
import 'header.dart';

class AboutPopup extends StatelessWidget {
  const AboutPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final featureWidgets = buildFeatureSection(
      sectionTitle: '⚙️ Key Features',
      features: const [
        FeatureItem(
            label: 'Real-Time Monitoring',
            description: 'Tracks key air quality indicators.'),
        FeatureItem(
            label: 'Cleanliness Alerts',
            description: 'Notifies janitors when cleaning is needed.'),
        FeatureItem(
            label: 'Role-Based Dashboard',
            description: 'Different views for admins and janitors.'),
        FeatureItem(
            label: 'Data History',
            description: 'Logs trends in restroom air quality.'),
        FeatureItem(
            label: 'ML Insights',
            description:
                'Predicts cleanliness status using gradient boosting.'),
      ],
    );
    final benefitWidgets = buildFeatureSection(
      sectionTitle: '✨ Benefits',
      features: const [
        FeatureItem(
            label: 'Cleaner Restrooms',
            description: 'Real-time monitoring ensures timely cleaning.'),
        FeatureItem(
            label: 'Faster Response',
            description: 'Janitors receive alerts when action is needed.'),
        FeatureItem(
            label: 'Smarter Scheduling',
            description: 'Trends help admins adjust cleaning routines.'),
        FeatureItem(
            label: 'Better Hygiene',
            description: 'Maintains cleanliness, reducing complaints.'),
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Header(title: 'About Clairity'),
              const SizedBox(height: 5),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      _buildLogoBox(),
                      const SizedBox(height: 20),
                      Text(
                        'Clairity is an AI-powered system that monitors indoor air quality in restrooms using environmental sensors. '
                        'Designed to support janitorial efficiency, Clairity ensures cleanliness through real-time data and intelligent alerts.',
                        textAlign: TextAlign.justify,
                        style: kSubheading,
                      ),
                      const SizedBox(height: 10),
                      const Divider(height: 20),
                      ...featureWidgets,
                      const Divider(height: 20),
                      ...benefitWidgets
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



  Widget _buildLogoBox() { //TODO: put logo image here.
    return Center(
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: oliveGreen,
        ),
      ),
    );
  }
}
