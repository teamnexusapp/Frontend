import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/localization_provider.dart';
import '../educational/article_reading_screen.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  int _selectedIndex = 3;
  String _currentAffirmation =
      'Every challenge is an opportunity to grow stronger and wiser.';
  final String _supportArticleTitle = 'Infertility Is Not a Curse';
  final String _supportArticleExcerpt =
      'In many Nigerian and African communities, pressure to conceive can be heavy. Infertility is a medical challenge, not a curse or a failure.';
  final String _supportArticleContent = '''If you are trying to conceive and it has not happened yet, remember this: infertility is not a curse or a punishment.

In many Nigerian and African societies, motherhood is tightly linked to identity, and delays can bring painful pressure. Terms like "barren" or "waiting on God" can leave emotional wounds, but difficulty conceiving is a medical and biological challenge, not a spiritual verdict.

Infertility has many possible causes: hormonal imbalances, infections, fibroids, blocked tubes, age, stress, or male-factor issues. Men and women are affected nearly equally, yet women often carry the blame alone.

You deserve care, not shame. Seeking medical help does not mean you lack faith. Many women conceive after proper diagnosis, treatment, lifestyle changes, or assisted medical support. And even when the journey is long, your life has meaning and purpose beyond motherhood.

Be kind to yourself. Protect your mental and emotional health. Surround yourself with people who support you, ask questions, seek credible medical advice, and give yourself permission to hope without self-blame. Your body is not your enemy, and your story is not over.''';
  final String _supportArticleImage = 'https://picsum.photos/800/300?random=103';

  void _onNavBarTap(int index) {
    if (index == _selectedIndex) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 20),
            decoration: const BoxDecoration(
              color: Color(0xFF2E683D),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Support hub',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Mental health support and daily affirmations',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 361,
                    height: 130,
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
                        Row(
                          children: [
                            const Icon(
                              Icons.flash_on,
                              color: Color(0xFF2E683D),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Daily affirmation',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2E683D),
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _currentAffirmation = 'You are stronger than you think.';
                                });
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.refresh,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _currentAffirmation,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF2E683D),
                            fontFamily: 'Poppins',
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Cultural Guidance',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(
                      _supportArticleExcerpt,
                      style: TextStyle(color: Colors.grey.shade700, height: 1.35),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ArticleReadingScreen(
                              imageUrl: _supportArticleImage,
                              title: _supportArticleTitle,
                              articleText: _supportArticleContent,
                            ),
                          ),
                        );
                      },
                      child: const Text('Read full message'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(loc.translate('exploreCommunityGroups')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
