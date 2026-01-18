import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';

class ArticleReadingScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String articleText;
  final String? audioUrl; // Optional audio URL

  const ArticleReadingScreen({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.articleText,
    this.audioUrl,
  }) : super(key: key);

  @override
  State<ArticleReadingScreen> createState() => _ArticleReadingScreenState();
}

class _ArticleReadingScreenState extends State<ArticleReadingScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlayingAudio = false;
  Duration _audioDuration = Duration.zero;
  Duration _audioPosition = Duration.zero;
  bool _isLoadingAudio = false;

  @override
  void initState() {
    super.initState();
    _initializeAudioPlayer();
  }

  void _initializeAudioPlayer() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlayingAudio = state == PlayerState.playing;
        });
      }
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      if (mounted) {
        setState(() {
          _audioDuration = duration;
        });
      }
    });

    _audioPlayer.onPositionChanged.listen((position) {
      if (mounted) {
        setState(() {
          _audioPosition = position;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }


  Future<void> _loadAudio() async {
    setState(() => _isLoadingAudio = true);
    try {
      if (widget.audioUrl != null && widget.audioUrl!.isNotEmpty) {
        final src = widget.audioUrl!;
        try {
          if (src.startsWith('http://') || src.startsWith('https://')) {
            await _audioPlayer.play(UrlSource(src));
          } else {
            await _audioPlayer.play(AssetSource(src));
          }
        } catch (e) {
          debugPrint('Error loading audio: $e');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  kIsWeb
                      ? 'Audio failed to load on web. Use MP3 assets and avoid spaces in filenames.'
                      : 'Failed to load audio.',
                ),
              ),
            );
          }
        }
      }
    } catch (e) {
      debugPrint('Error loading audio: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load audio: $e')),
        );
      }
    } finally {
      setState(() => _isLoadingAudio = false);
    }
  }

  Future<void> _togglePlayPause() async {
    if (_isLoadingAudio) return;

    if (_isPlayingAudio) {
      await _audioPlayer.pause();
    } else {
      if (_audioPosition == Duration.zero) {
        // Audio hasn't been loaded yet, load and play
        if (widget.audioUrl != null && widget.audioUrl!.isNotEmpty) {
          final src = widget.audioUrl!;
          try {
            if (src.startsWith('http://') || src.startsWith('https://')) {
              await _audioPlayer.play(UrlSource(src));
            } else {
              await _audioPlayer.play(AssetSource(src));
            }
          } catch (e) {
            debugPrint('Error starting audio: $e');
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
      } else {
        // Resume from where it was paused
        try {
          await _audioPlayer.resume();
        } catch (e) {
          debugPrint('Resume failed: $e');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  kIsWeb
                      ? 'Resume failed on web audio.'
                      : 'Resume failed.',
                ),
              ),
            );
          }
        }
      }
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

  void _showAudioPlayerModal() {
    _loadAudio();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return WillPopScope(
              onWillPop: () async {
                // Stop audio when modal is dismissed
                await _audioPlayer.stop();
                return true;
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Handle bar
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // Modal title
                    const Text(
                      'Listen to Article',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 20),
                  // Audio Player Controls
                  Container(
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
                        if (_isLoadingAudio)
                          const CircularProgressIndicator()
                        else
                          IconButton(
                            iconSize: 64,
                            icon: Icon(
                              _isPlayingAudio ? Icons.pause_circle_filled : Icons.play_circle_filled,
                              color: const Color(0xFF2E683D),
                            ),
                            onPressed: () async {
                              await _togglePlayPause();
                              setModalState(() {});
                            },
                          ),
                        const SizedBox(height: 16),
                        // Progress Bar
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                            trackHeight: 4,
                          ),
                          child: Slider(
                            value: _audioPosition.inSeconds.toDouble(),
                            max: _audioDuration.inSeconds.toDouble().clamp(1.0, double.infinity),
                            activeColor: const Color(0xFF2E683D),
                            inactiveColor: Colors.grey.shade300,
                            onChanged: (value) async {
                              final position = Duration(seconds: value.toInt());
                              await _audioPlayer.seek(position);
                              setModalState(() {});
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
                                _formatDuration(_audioPosition),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF2E683D),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                _formatDuration(_audioDuration - _audioPosition),
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
                  const SizedBox(height: 20),
                  // Close button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _audioPlayer.stop();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E683D),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      // Ensure audio is stopped when modal is dismissed
      _audioPlayer.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Fixed header with back and listen buttons
          Container(
            color: const Color(0xFF2E683D),
            padding: const EdgeInsets.only(top: 40, left: 8, right: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const Text(
                  'Read Article',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up, color: Colors.white),
                  onPressed: _showAudioPlayerModal,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                // Article image
                Image.asset(
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
                // Article text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.articleText,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
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
