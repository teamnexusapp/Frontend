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
    return allArticles
        .where((article) => article['category'] == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF2F6F3E);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Educational Hub'),
        backgroundColor: green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) {
                final isSelected = category == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                    backgroundColor: Colors.grey.shade200,
                    selectedColor: green,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          
          // Articles list
          if (filteredArticles.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Text(
                  'No articles found for this category',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
            )
          else
            Column(
              children: filteredArticles.map((article) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
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
                              Text(
                                article['title']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                article['excerpt']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Opening: ${article['title']}'),
                                      ),
                                    );
                                  },
                                  child: const Text('Read More'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
