import 'package:flutter/material.dart';
import 'package:nexus_fertility_app/flutter_gen/gen_l10n/app_localizations.dart';

class EducationalHubScreen extends StatefulWidget {
  const EducationalHubScreen({Key? key}) : super(key: key);

  @override
  State<EducationalHubScreen> createState() => _EducationalHubScreenState();
}

class _EducationalHubScreenState extends State<EducationalHubScreen> {
  int activeFilter = 0;
  final filters = ['Fertility basics', 'Myths & Facts', 'Trying to conceive'];
  final allArticles = [
    {
      'category': 'Fertility basics',
      'title': "Infertility isn't a curse",
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'duration': '5 minutes read',
    },
    {
      'category': 'Fertility basics',
      'title': 'Understanding Your Fertility Cycle',
      'description': 'Learn the phases of your cycle and what happens each day. Understanding your body is the first step to fertility awareness.',
      'duration': '4 minutes read',
    },
    {
      'category': 'Fertility basics',
      'title': 'The Role of Hormones',
      'description': 'Discover how hormones regulate your fertility and reproductive health throughout your cycle.',
      'duration': '6 minutes read',
    },
    {
      'category': 'Myths & Facts',
      'title': 'Debunking Common Fertility Myths',
      'description': 'Separating fact from fiction in fertility. Learn the truth about common misconceptions.',
      'duration': '5 minutes read',
    },
    {
      'category': 'Myths & Facts',
      'title': 'Age and Fertility: What You Need to Know',
      'description': 'Understanding the relationship between age and fertility without the fear and stigma.',
      'duration': '7 minutes read',
    },
    {
      'category': 'Myths & Facts',
      'title': 'Stress and Conception',
      'description': 'Does stress really affect fertility? Get the facts about stress, relaxation, and conception.',
      'duration': '4 minutes read',
    },
    {
      'category': 'Trying to conceive',
      'title': 'Optimize Your Chances',
      'description': 'Best practices for couples trying to conceive. Practical tips for your journey.',
      'duration': '8 minutes read',
    },
    {
      'category': 'Trying to conceive',
      'title': 'Timing and Frequency',
      'description': 'How often and when to have intercourse for the best chances of conception.',
      'duration': '5 minutes read',
    },
    {
      'category': 'Trying to conceive',
      'title': 'Healthy Lifestyle Choices',
      'description': 'Nutrition, exercise, and lifestyle factors that support fertility and conception.',
      'duration': '6 minutes read',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredArticles = allArticles
        .where((article) => article['category'] == filters[activeFilter])
        .toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Educational Hub'),
        backgroundColor: const Color(0xFF2E683D),
      ),
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
                Positioned(
                  right: 57,
                  top: 0,
                  bottom: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.bookmark,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  filters.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(right: index < filters.length - 1 ? 12 : 0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          activeFilter = index;
                        });
                      },
                      child: Container(
                        width: 140,
                        height: 46.2,
                        decoration: BoxDecoration(
                          color: activeFilter == index
                              ? const Color(0xFF2E683D)
                              : Colors.white,
                          border: activeFilter == index
                              ? null
                              : Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            filters[index],
                            style: TextStyle(
                              color:
                                  activeFilter == index ? Colors.white : Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: filteredArticles.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final article = filteredArticles[index];
                return _buildArticleCard(
                  title: article['title']!,
                  description: article['description']!,
                  category: article['category']!,
                  duration: article['duration']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard({
    required String title,
    required String description,
    required String category,
    required String duration,
  }) {
    return Container(
      width: 362,
      height: 531,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 323,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E683D).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF2E683D),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  duration,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 16),
            child: Row(
              children: [
                Container(
                  width: 90,
                  height: 29,
                  color: const Color(0xFF2E683D),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.play_arrow, color: Colors.white, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'Listen',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFA8D497).withOpacity(0.4),
                  ),
                  child: const Text(
                    'English',
                    style: TextStyle(
                      color: Color(0xFF2E683D),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.bookmark,
                    size: 18,
                    color: Color(0xFF2E683D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
