import 'package:flutter/material.dart';
import 'package:nexus_fertility_app/widgets/app_bar.dart';

class EducationalHubScreen extends StatelessWidget {
  const EducationalHubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Educational Hub',
        showBacklabelLarge: true,
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text('Understanding Your Cycle'),
            subtitle: Text('Learn about the phases of your menstrual cycle.'),
          ),
          ListTile(
            title: Text('Fertility Awareness Methods'),
            subtitle: Text('Natural ways to track your fertility.'),
          ),
          ListTile(
            title: Text('Nutrition and Fertility'),
            subtitle: Text('How diet affects your reproductive health.'),
          ),
          ListTile(
            title: Text('Common Fertility Myths'),
            subtitle: Text('Debunking misconceptions about conception.'),
          ),
        ],
      ),
    );
  }
}



