import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../services/localization_provider.dart';

class AudioHubScreen extends StatefulWidget {
  const AudioHubScreen({super.key});

  @override
  State<AudioHubScreen> createState() => _AudioHubScreenState();
}

class _AudioHubScreenState extends State<AudioHubScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _playingIndex;
  double _playbackSpeed = 1.0;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _setPlaybackSpeed(double speed) async {
    try {
      await _audioPlayer.setPlaybackRate(speed);
      setState(() => _playbackSpeed = speed);
    } catch (e) {
      // Gracefully handle WebAudio errors on web
      debugPrint('Playback rate change failed: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              kIsWeb
                  ? 'Playback speed not supported by current browser/audio backend.'
                  : 'Failed to change playback speed.',
            ),
          ),
        );
      }
    }
  }

  final List<Map<String, String>> _lessons = const [
    {
      'title': 'Understanding Your Menstrual Cycle',
      'content': 'Learn the phases of your cycle and how they affect fertility.',
      'audioUrl': 'audio/article_1.mp3'
    },
    {
      'title': 'What is Ovulation?',
      'content': 'Ovulation is when an egg is released from the ovary.',
      'audioUrl': 'audio/article_2.mp3'
    },
    {
      'title': 'Fertility in your 20s, 30s and 40s',
      'content': 'Fertility changes with age — learn how to plan and prepare.',
      'audioUrl': 'audio/article_3.mp3'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('audioLessons')),
      ),
      body: Column(
        children: [
          // Speed control bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.grey.shade100,
            child: Row(
              children: [
                const Text('Speed:',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                const SizedBox(width: 12),
                ...[0.75, 1.0, 1.25, 1.5, 2.0].map((speed) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _playbackSpeed == speed
                            ? const Color(0xFF2E683D)
                            : Colors.grey.shade300,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      ),
                      onPressed: () => _setPlaybackSpeed(speed),
                      child: Text(
                        speed == 1.0 ? '1x' : '${speed}x',
                        style: TextStyle(
                          color: _playbackSpeed == speed ? Colors.white : Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          // Audio lessons list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _lessons.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _lessons[index];
                final isPlaying = _playingIndex == index;

                return StreamBuilder<PlayerState>(
                  stream: _audioPlayer.onPlayerStateChanged,
                  builder: (context, snapshot) {
                    final isCurrentlyPlaying = isPlaying && (snapshot.data == PlayerState.playing);
                    
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
                            icon: Icon(isCurrentlyPlaying ? Icons.pause : Icons.play_arrow),
                            onPressed: () async {
                              if (isCurrentlyPlaying) {
                                await _audioPlayer.pause();
                              } else {
                                if (_playingIndex != index) {
                                  setState(() => _playingIndex = index);
                                }
                                try {
                                  await _audioPlayer.play(
                                    AssetSource(item['audioUrl']!),
                                  );
                                } catch (e) {
                                  debugPrint('Audio play failed: $e');
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          kIsWeb
                                              ? 'Audio failed to play on web. Ensure assets are MP3 and paths have no spaces.'
                                              : 'Audio failed to play.',
                                        ),
                                      ),
                                    );
                                  }
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
