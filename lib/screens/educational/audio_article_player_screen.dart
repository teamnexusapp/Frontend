import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioArticlePlayerScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String articleText;
  final String? audioUrl; // Placeholder URL for now

  const AudioArticlePlayerScreen({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.articleText,
    this.audioUrl,
  }) : super(key: key);

  @override
  State<AudioArticlePlayerScreen> createState() => _AudioArticlePlayerScreenState();
}

class _AudioArticlePlayerScreenState extends State<AudioArticlePlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeAudioPlayer();
  }

  void _initializeAudioPlayer() {
    // Listen to player state changes
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });

    // Listen to duration changes
    _audioPlayer.onDurationChanged.listen((duration) {
      if (mounted) {
        setState(() {
          _duration = duration;
        });
      }
    });

    // Listen to position changes
    _audioPlayer.onPositionChanged.listen((position) {
      if (mounted) {
        setState(() {
          _position = position;
        });
      }
    });

    // Auto-load audio if URL is provided
    if (widget.audioUrl != null && widget.audioUrl!.isNotEmpty) {
      _loadAudio();
    }
  }

  Future<void> _loadAudio() async {
    setState(() => _isLoading = true);
    try {
      // Use provided audio URL
      final audioUrl = widget.audioUrl;
      if (audioUrl != null && audioUrl.isNotEmpty) {
        await _audioPlayer.setSourceUrl(audioUrl);
      }
    } catch (e) {
      debugPrint('Error loading audio: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load audio: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _togglePlayPause() async {
    if (_isLoading) return;

    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      if (_position == Duration.zero && (widget.audioUrl == null || widget.audioUrl!.isEmpty)) {
        // No audio URL provided
        return;
      }
      await _audioPlayer.resume();
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Fixed header with back button
          Container(
            color: const Color(0xFF2E683D),
            padding: const EdgeInsets.only(top: 40, left: 8, right: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    _audioPlayer.stop();
                    Navigator.of(context).pop();
                  },
                ),
                const Text(
                  'Audio Article',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(width: 48), // Spacer for alignment
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                // Article image
                Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 220,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 220,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image_not_supported),
                  ),
                ),
                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E683D),
                    ),
                  ),
                ),
                // Audio Player Section
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      // Play/Pause Button
                      if (_isLoading)
                        const CircularProgressIndicator()
                      else
                        IconButton(
                          iconSize: 64,
                          icon: Icon(
                            _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                            color: const Color(0xFF2E683D),
                          ),
                          onPressed: _togglePlayPause,
                        ),
                      const SizedBox(height: 16),
                      // Progress Bar
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                          trackHeight: 4,
                        ),
                        child: Slider(
                          value: _position.inSeconds.toDouble(),
                          max: _duration.inSeconds.toDouble().clamp(1.0, double.infinity),
                          activeColor: const Color(0xFF2E683D),
                          inactiveColor: Colors.grey.shade300,
                          onChanged: (value) async {
                            final position = Duration(seconds: value.toInt());
                            await _audioPlayer.seek(position);
                          },
                        ),
                      ),
                      // Time Display
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatDuration(_position),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF2E683D),
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              _formatDuration(_duration - _position),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Article text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(
                    widget.articleText,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
