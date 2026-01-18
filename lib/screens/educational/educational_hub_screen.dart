import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../theme.dart';
import 'article_reading_screen.dart';

class EducationalHubScreen extends StatefulWidget {
  const EducationalHubScreen({super.key});

  @override
  State<EducationalHubScreen> createState() => _EducationalHubScreenState();
}

class _EducationalHubScreenState extends State<EducationalHubScreen> {
  String selectedCategory = 'Fertility Basics';
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _showAudioModal(BuildContext context, Map<String, String> article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AudioPlayerModal(
        audioPlayer: _audioPlayer,
        article: article,
      ),
    );
  }

  final List<Map<String, String>> allArticles = [
    {
      'category': 'Fertility Basics',
      'title': 'How Pregnancy Happens: A Simple Guide to Conception',
      'excerpt':
          'Conception happens when sperm fertilizes an egg and the embryo implants. Learn when the fertile window opens and how health, timing, and patience support TTC.',
      'image': 'lib/screens/educational/article 1.jpeg',
      'audioUrl': 'audio/article_1.mp3',
      'content': '''Getting pregnant happens when a sperm fertilizes an egg and the fertilized egg successfully implants in the uterus. Understanding this helps improve your chances.

Understanding the fertile window
You are most likely to conceive during the fertile window: the days leading up to and including ovulation (about 14 days before the next period in a regular cycle). Because sperm can live in the body for several days, pregnancy can happen if sperm is present during this time.

Healthy body, better chances
Good overall health supports conception. Eat balanced meals, stay hydrated, manage stress, sleep well, and avoid smoking and alcohol. Maintaining a healthy weight matters, since being underweight or overweight can affect ovulation.

Tracking ovulation
- Monitoring menstrual cycles (this is included in the Fertilpath app)
- Watching for changes in cervical mucus
- Using ovulation predictor kits

These tools help you know your most fertile days.

Medical checkups matter
Before trying to conceive, see a healthcare provider. They can advise on prenatal vitamins like folic acid, review any health conditions, and guide you toward a healthy pregnancy.

Patience is normal
Even with perfect timing, it can take months to conceive. That is normal and does not always mean something is wrong. Consider seeing a doctor if you have tried for 12 months (or sooner if over 35).''',
    },
    {
      'category': 'Fertility Basics',
      'title': 'How Long Does Ovulation Last?',
      'excerpt':
          'Ovulation is brief (12-24 hours), but sperm can live up to five days. Knowing this window helps plan or prevent pregnancy.',
      'image': 'lib/screens/educational/article 2.jpeg',
      'audioUrl': 'audio/article_2.mp3',
      'content': '''Ovulation is when an ovary releases a mature egg. The egg lives about 12 to 24 hours, and can be fertilized only in that short time.

The fertile window
Even though ovulation is brief, sperm can survive in the reproductive tract for up to five days. Pregnancy can happen if sperm are present in the days before ovulation or on the ovulation day itself.

When ovulation occurs
In a regular cycle, ovulation is roughly 14 days before the next period, but timing varies by person and by cycle.

Signs of ovulation
Some people notice mild lower abdominal discomfort or changes in cervical mucus around ovulation. These clues can help identify fertile days, but they differ for everyone.

Why it matters
Knowing how long ovulation lasts and how long sperm survive can guide timing for conception, family planning, or simply understanding your body.''',
    },
    {
      'category': 'Myths & Facts',
      'title': 'Infertility Is Not a Curse',
      'excerpt':
          'In many Nigerian and African communities, pressure to conceive is heavy. Infertility is a medical challenge, not a curse or a failure.',
      'image': 'lib/screens/educational/article 3.jpeg',
      'audioUrl': 'audio/article_3.mp3',
      'content': '''If you are trying to conceive and it has not happened yet, remember this: infertility is not a curse or a punishment.

In many Nigerian and African societies, motherhood is tightly linked to identity, and delays can bring painful pressure. Terms like "barren" or "waiting on God" can leave emotional wounds, but difficulty conceiving is a medical and biological challenge, not a spiritual verdict.

Infertility has many possible causes: hormonal imbalances, infections, fibroids, blocked tubes, age, stress, or male-factor issues. Men and women are affected nearly equally, yet women often carry the blame alone.

You deserve care, not shame. Seeking medical help does not mean you lack faith. Many women conceive after proper diagnosis, treatment, lifestyle changes, or assisted medical support. And even when the journey is long, your life has meaning and purpose beyond motherhood.

Be kind to yourself. Protect your mental and emotional health. Surround yourself with people who support you, ask questions, seek credible medical advice, and give yourself permission to hope—without self-blame. Your body is not your enemy, and your story is not over.''',
    },
  ];

  final List<String> categories = [
    'Fertility Basics',
    'Myths & Facts',
  ];

  Widget _buildArticleCard(Map<String, String> article) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ArticleReadingScreen(
                imageUrl: article['image'] ?? '',
                title: article['title'] ?? '',
                articleText: article['content'] ?? article['excerpt'] ?? '',
                audioUrl: article['audioUrl'], // Pass audio URL
              ),
            ),
          );
        },
        child: Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.asset(
                  article['image']!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 180,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image_not_supported),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFA8D497),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            article['category'] ?? '',
                            style: const TextStyle(
                              color: Color(0xFF2E683D),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          '5 mins read',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      article['title'] ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E683D),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      article['excerpt'] ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _showAudioModal(context, article),
                          child: Container(
                            height: 32,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: const BoxDecoration(
                              color: Color(0xFF2E683D),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.play_arrow, color: Colors.white, size: 18),
                                SizedBox(width: 4),
                                Text(
                                  'Listen',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 32,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: const BoxDecoration(
                            color: Color(0xFFA8D497),
                          ),
                          child: const Center(
                            child: Text(
                              'English',
                              style: TextStyle(
                                color: Color(0xFF2E683D),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
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

  @override
  Widget build(BuildContext context) {
    final filteredArticles = allArticles
        .where((article) => article['category'] == selectedCategory)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Educational Hub', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          // Category selector
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: selectedCategory,
                isExpanded: true,
                underline: const SizedBox(),
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: const TextStyle(
                        color: Color(0xFF2E683D),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedCategory = value;
                    });
                  }
                },
              ),
            ),
          ),
          // Articles list
          Expanded(
            child: Container(
              color: Colors.grey[100],
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: filteredArticles
                    .map((article) => _buildArticleCard(article))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AudioPlayerModal extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final Map<String, String> article;

  const AudioPlayerModal({
    Key? key,
    required this.audioPlayer,
    required this.article,
  }) : super(key: key);

  @override
  State<AudioPlayerModal> createState() => _AudioPlayerModalState();
}

class _AudioPlayerModalState extends State<AudioPlayerModal> {
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double _playbackSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    _setupAudioPlayer();
    _loadAudio();
  }

  void _setupAudioPlayer() {
    widget.audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() => _isPlaying = state == PlayerState.playing);
      }
    });

    widget.audioPlayer.onDurationChanged.listen((duration) {
      if (mounted) {
        setState(() => _duration = duration);
      }
    });

    widget.audioPlayer.onPositionChanged.listen((position) {
      if (mounted) {
        setState(() => _position = position);
      }
    });
  }

  Future<void> _loadAudio() async {
    if (widget.article['audioUrl']!.isNotEmpty) {
      await widget.audioPlayer.setSourceAsset(widget.article['audioUrl']!);
      await widget.audioPlayer.setPlaybackRate(_playbackSpeed);
    }
  }

  Future<void> _togglePlayPause() async {
    if (_isPlaying) {
      await widget.audioPlayer.pause();
    } else {
      await widget.audioPlayer.resume();
    }
  }

  Future<void> _setSpeed(double speed) async {
    await widget.audioPlayer.setPlaybackRate(speed);
    setState(() => _playbackSpeed = speed);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.article['title'] ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E683D),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Progress bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 4,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
                        ),
                        child: Slider(
                          activeColor: const Color(0xFF2E683D),
                          inactiveColor: Colors.grey.shade300,
                          min: 0,
                          max: _duration.inSeconds.toDouble(),
                          value: _position.inSeconds.toDouble().clamp(0, _duration.inSeconds.toDouble()),
                          onChanged: (value) async {
                            await widget.audioPlayer.seek(Duration(seconds: value.toInt()));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatDuration(_position),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              _formatDuration(_duration),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Playback controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.skip_previous),
                        onPressed: () async {
                          await widget.audioPlayer.seek(Duration.zero);
                        },
                      ),
                      const SizedBox(width: 16),
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF2E683D),
                        ),
                        child: IconButton(
                          icon: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                          ),
                          iconSize: 32,
                          onPressed: _togglePlayPause,
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.skip_next),
                        onPressed: () async {
                          await widget.audioPlayer.seek(_duration);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Speed controls
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Playback Speed',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [0.75, 1.0, 1.25, 1.5, 2.0].map((speed) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _playbackSpeed == speed
                                    ? const Color(0xFF2E683D)
                                    : Colors.grey.shade300,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () => _setSpeed(speed),
                              child: Text(
                                speed == 1.0 ? '1x' : '${speed}x',
                                style: TextStyle(
                                  color: _playbackSpeed == speed ? Colors.white : Colors.black87,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
