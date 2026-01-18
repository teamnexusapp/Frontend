import 'package:flutter/material.dart';

class CulturalGuidanceScreen extends StatefulWidget {
  const CulturalGuidanceScreen({super.key});

  @override
  State<CulturalGuidanceScreen> createState() => _CulturalGuidanceScreenState();
}

class _CulturalGuidanceScreenState extends State<CulturalGuidanceScreen> {
  final List<GuidanceSection> guidanceSections = [
    GuidanceSection(
      title: 'Family Communication',
      icon: Icons.people_outline,
      content: 'Navigate conversations about fertility with family members respectfully and confidently.',
      subsections: [
        'When to share your fertility journey with family',
        'How to set boundaries with well-meaning relatives',
        'Handling unsolicited advice and comments',
        'Building support within your family unit',
        'Respecting cultural values while pursuing your goals',
      ],
    ),
    GuidanceSection(
      title: 'Cultural Practices & Fertility',
      icon: Icons.spa_outlined,
      content: 'Understanding traditional practices alongside modern medical care.',
      subsections: [
        'Herbal remedies and their evidence base',
        'Traditional healing practices in different cultures',
        'Integrating traditional wisdom with medical advice',
        'Respecting ancestral knowledge',
        'Finding balance between old and new',
      ],
    ),
    GuidanceSection(
      title: 'Community & Stigma',
      icon: Icons.people_outline,
      content: 'Building strength through community while managing cultural stigma.',
      subsections: [
        'Finding supportive communities that understand your culture',
        'Addressing stigma around infertility in your community',
        'Sharing your story safely and selectively',
        'Building chosen family and support networks',
        'Celebrating cultural celebrations and milestones',
      ],
    ),
    GuidanceSection(
      title: 'Marriage & Partnership',
      icon: Icons.favorite_outline,
      content: 'Strengthening your relationship through fertility challenges.',
      subsections: [
        'Open communication with your partner about expectations',
        'Understanding cultural roles and modern partnerships',
        'Managing stress together as a couple',
        'Seeking couples counseling when needed',
        'Honoring cultural traditions in your relationship',
      ],
    ),
    GuidanceSection(
      title: 'Mental Health & Spirituality',
      icon: Icons.psychology_outlined,
      content: 'Caring for your emotional and spiritual wellbeing.',
      subsections: [
        'Using spirituality as a source of strength',
        'Managing anxiety and depression culturally sensitively',
        'Prayer, meditation, and mindfulness practices',
        'Finding therapists who understand your culture',
        'Coping with grief and loss respectfully',
      ],
    ),
    GuidanceSection(
      title: 'Resources & Reading',
      icon: Icons.library_books_outlined,
      content: 'Recommended resources from diverse cultural perspectives.',
      subsections: [
        'Books on fertility from multicultural perspectives',
        'Online communities for your cultural background',
        'Websites with culturally sensitive information',
        'Podcasts discussing fertility and culture',
        'Organizations supporting diverse families',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E683D),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Cultural Guidance',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFA8D497).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF2E683D),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome to Cultural Guidance',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2E683D),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Navigate your fertility journey while honoring your cultural values, traditions, and family expectations.',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade700,
                      fontFamily: 'Poppins',
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Guidance Sections
            ...guidanceSections.map((section) {
              return Column(
                children: [
                  _buildGuidanceCard(section),
                  const SizedBox(height: 12),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidanceCard(GuidanceSection section) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          expansionTileTheme: ExpansionTileThemeData(
            backgroundColor: Colors.grey.shade50,
            collapsedBackgroundColor: Colors.white,
          ),
        ),
        child: ExpansionTile(
          leading: Icon(
            section.icon,
            color: const Color(0xFF2E683D),
            size: 24,
          ),
          title: Text(
            section.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2E683D),
              fontFamily: 'Poppins',
            ),
          ),
          subtitle: Text(
            section.content,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600,
              fontFamily: 'Poppins',
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...section.subsections.map((subsection) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 4, right: 8),
                            child: Icon(
                              Icons.check_circle_outline,
                              color: Color(0xFFA8D497),
                              size: 18,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              subsection,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GuidanceSection {
  final String title;
  final IconData icon;
  final String content;
  final List<String> subsections;

  GuidanceSection({
    required this.title,
    required this.icon,
    required this.content,
    required this.subsections,
  });
}
