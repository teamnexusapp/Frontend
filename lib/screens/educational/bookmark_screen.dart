import 'package:flutter/material.dart';

class BookmarkScreen extends StatelessWidget {
  final List<Map<String, String>> bookmarkedArticles;
  const BookmarkScreen({Key? key, required this.bookmarkedArticles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E683D),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Bookmarks', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bookmarkedArticles.length,
        itemBuilder: (context, index) {
          final article = bookmarkedArticles[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _ArticleCard(article: article),
          );
        },
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final Map<String, String> article;
  const _ArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article['image'] != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                article['image']!,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article['title'] ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  article['excerpt'] ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    // Listen container
                    Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E683D),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.volume_up, color: Colors.white, size: 18),
                          SizedBox(width: 4),
                          Text('Listen', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Language container
                    Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        color: Color(0xFFA8D497),
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Center(
                        child: Text(
                          article['language'] ?? 'English',
                          style: const TextStyle(
                            color: Color(0xFF2E683D),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.bookmark, color: Color(0xFF2E683D)),
                      onPressed: () {
                        // Optionally: Remove from bookmarks
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
