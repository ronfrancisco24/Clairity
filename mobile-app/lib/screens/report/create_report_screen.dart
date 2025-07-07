import 'package:flutter/material.dart';

class CreateReportScreen extends StatelessWidget {
  const CreateReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Creation'),
      ),
      body: const Center(
        child: Text('Report Creation Content'),
      ),
      // No bottomNavigationBar here!
    );
  }
}