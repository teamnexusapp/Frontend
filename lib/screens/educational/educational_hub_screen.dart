import 'package:flutter/material.dart';
import 'article_reading_screen.dart';

class EducationalHubScreen extends StatefulWidget {
  static const routeName = '/educational-hub';
  const EducationalHubScreen({Key? key}) : super(key: key);

  @override
  State<EducationalHubScreen> createState() => _EducationalHubScreenState();
}

class _EducationalHubScreenState extends State<EducationalHubScreen> {
  String selectedCategory = 'Fertility Basics';

  // Sample articles data
  final List<Map<String, String>> allArticles = [
    {
      'category': 'Fertility Basics',
      'title': 'Understanding Your Menstrual Cycle',
      'excerpt': 'Learn the phases of your cycle and what happens each day...',
      'image': 'https://picsum.photos/800/300?random=1',
    },
    {
      'category': 'Fertility Basics',
      'title': 'The Role of Hormones',
      'excerpt': 'Discover how hormones regulate your fertility...',
      'image': 'https://picsum.photos/800/300?random=2',
    },
    {
      'category': 'Myths & Facts',
      'title': 'Infertility isn\'t a curse',
      'excerpt': 'Short excerpt of the article goes here...',
      'image': 'https://picsum.photos/800/300?random=3',
    },
    {
      'category': 'Myths & Facts',
      'title': 'Debunking Common Fertility Myths',
      'excerpt': 'Separating fact from fiction in fertility...',
      'image': 'https://picsum.photos/800/300?random=4',
    },
    {
      'category': 'Trying to conceive',
      'title': 'Optimize Your Chances',
      'excerpt': 'Best practices for couples trying to conceive...',
      'image': 'https://picsum.photos/800/300?random=5',
    },
    {
      'category': 'Trying to conceive',
      'title': 'Timing and Frequency',
      'excerpt': 'How often and when to have intercourse...',
      'image': 'https://picsum.photos/800/300?random=6',
    },
  ];

  final List<String> categories = [
    'Fertility Basics',
    'Myths & Facts',
    'Trying to conceive',
  ];

  Widget _buildArticleCard(Map<String, String> article) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ArticleReadingScreen(
                imageUrl: article['image'] ?? '',
                title: article['title'] ?? '',
                articleText: article['excerpt'] ?? '',
              ),
            ),
          );
        },
        child: Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final cardHeight = 320.0;
                final imageHeight = cardHeight * 0.6;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                      child: Image.network(
                        article['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: imageHeight,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: imageHeight,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.image_not_supported),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
                      child: Row(
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
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '5 mins read',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
                      child: Text(
                        article['title'] ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12, top: 6),
                      child: Text(
                        article['excerpt'] ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 32,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E683D),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.play_arrow, color: Colors.white, size: 18),
                                SizedBox(width: 4),
                                Text('Listen', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 3),
                          Container(
                            height: 32,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFA8D497),
                              borderRadius: BorderRadius.zero,
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
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final filteredArticles = allArticles.where((article) => article['category'] == selectedCategory).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Educational Hub', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF2E683D), // Dark green
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  final isSelected = selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : const Color(0xFF2E683D),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: const Color(0xFF2E683D),
                      backgroundColor: Colors.white,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: isSelected ? const Color(0xFF2E683D) : Colors.white,
                          width: 2,
                        ),
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            selectedCategory = category;
                          });
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: filteredArticles.map((article) => _buildArticleCard(article)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
