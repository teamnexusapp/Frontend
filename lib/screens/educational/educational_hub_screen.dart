import 'package:flutter/material.dart';

class EducationalHubScreen extends StatelessWidget {
  static const routeName = '/educational-hub';
  const EducationalHubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF2F6F3E);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Educational Hub'),
        backgroundColor: green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Chip(backgroundColor: green, label: const Text('Fertility Basics', style: TextStyle(color: Colors.white))),
                const SizedBox(width: 8),
                const Chip(label: Text('Myths & Facts')),
                const SizedBox(width: 8),
                const Chip(label: Text('Trying to conceive')),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network('https://picsum.photos/800/300', fit: BoxFit.cover, width: double.infinity, height: 180),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Infertility isn\'t a curse', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('Short excerpt of the article goes here...'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
