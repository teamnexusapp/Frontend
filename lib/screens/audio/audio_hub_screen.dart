import '../../services/tts_service.dart';
import '../../services/localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioHubScreen extends StatelessWidget {
  const AudioHubScreen({super.key});

  final List<Map<String, String>> _lessons = const [
    {
      'title': 'Understanding Your Menstrual Cycle',
      'content': 'Learn the phases of your cycle and how they affect fertility.'
    },
    {
      'title': 'What is Ovulation?',
      'content': 'Ovulation is when an egg is released from the ovary.'
    },
    {
      'title': 'Fertility in your 20s, 30s and 40s',
      'content': 'Fertility changes with age â€” learn how to plan and prepare.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationProvider>(context);
    final tts = Provider.of<TtsService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('audioLessons')),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _lessons.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = _lessons[index];
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['title']!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(item['content']!,
                          style:
                              TextStyle(color: Colors.grey.shade600, height: 1.4)),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: Icon(tts.isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () async {
                    if (tts.isPlaying) {
                      await tts.stop();
                    } else {
                      await tts.speak(item['content']!);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}






