import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/encouragement_service.dart';
import '../../services/tts_service.dart';
import '../../services/localization_provider.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  FaithMode _mode = FaithMode.neutral;
  String _currentAffirmation = "Every challenge is an opportunity to grow stronger and wiser.";

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationProvider>(context);
    final encourager = EncouragementService();
    final tts = Provider.of<TtsService>(context);
    final message = encourager.dailyMessage(_mode);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Green appbar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 20),
            decoration: const BoxDecoration(
              color: Color(0xFF2E683D),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Support hub',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Mental health support and daily affirmations',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          // Body with daily affirmation and other content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Daily affirmation card
                  Container(
                    width: 361,
                    height: 130,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA8D497).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFF2E683D),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Top row: spark icon, text, refresh button
                        Row(
                          children: [
                            Icon(
                              Icons.flash_on,
                              color: const Color(0xFF2E683D),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Daily affirmation',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2E683D),
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _currentAffirmation = "You are stronger than you think.";
                                });
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.refresh,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Affirmation text (2 lines)
                        Text(
                          _currentAffirmation,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF2E683D),
                            fontFamily: 'Poppins',
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    loc.translate('chooseSupportMode'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _modeButton(FaithMode.neutral, 'Neutral'),
                      const SizedBox(width: 8),
                      _modeButton(FaithMode.christian, 'Christian'),
                      const SizedBox(width: 8),
                      _modeButton(FaithMode.muslim, 'Muslim'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.pink.shade100),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.favorite, color: Colors.pink),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(loc.translate('dailyAffirmation'),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                message,
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            tts.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.pink,
                          ),
                          onPressed: () async {
                            if (tts.isPlaying) {
                              await tts.stop();
                            } else {
                              await tts.speak(message);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Cultural Guidance',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(
                      'Coping with family pressure and finding peace in community support. Explore recommended readings and groups.',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(loc.translate('exploreCommunityGroups')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _modeButton(FaithMode mode, String label) {
    final isSelected = _mode == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _mode = mode),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.pink.shade100 : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.pink : Colors.grey.shade700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
