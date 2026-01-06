import 'package:flutter/material.dart';

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

  List<Map<String, String>> get filteredArticles {
    // Normalize category names for matching (case-insensitive, ignore & vs and)
    String normalize(String s) => s.toLowerCase().replaceAll('&', 'and').replaceAll(' ', '').replaceAll('-', '');
    final selectedNorm = normalize(selectedCategory);
    return allArticles.where((article) {
      final cat = article['category'] ?? '';
      return normalize(cat) == selectedNorm;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 110,
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.only(left: 30, right: 30),
            decoration: const BoxDecoration(
              color: Color(0xFF2E683D),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Educational Hub',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Filter bubbles
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  final bool isActive = selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(
                          color: isActive ? const Color(0xFF2E683D) : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isActive ? const Color(0xFF2E683D) : Colors.grey.shade300,
                            width: 1.5,
                          ),
                          boxShadow: isActive
                              ? [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.08),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isActive ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 16),
              children: filteredArticles.map((article) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
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
                              // Image (60% of card height)
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
                              // Row: Category and Duration
                              Padding(
                                padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
                                child: Row(
                                  children: [
                                    // Category
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
                                    // Duration (hardcoded for now)
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
                              // Title
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
                              // Paragraph
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
                              // Last row: Listen, Language, Bookmark
                              Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Listen button
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
                                    // Language
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
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
