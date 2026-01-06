import 'package:flutter/material.dart';

class ArticleReadingScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String articleText;

  const ArticleReadingScreen({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.articleText,
  }) : super(key: key);

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
                Text(
                  'Read Article',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up, color: Colors.white),
                  onPressed: () {
                    // TODO: Implement TTS/audio play
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                // Article image
                Image.network(
                  imageUrl,
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
                    title,
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
                    articleText,
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
