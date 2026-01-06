import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/localization_provider.dart';
import '../../services/api_service.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  int _selectedIndex = 3;
  String _currentAffirmation = "Every challenge is an opportunity to grow stronger and wiser.";
  List<String> _affirmations = [];
  String _faith = 'neutral';
  bool _loadingAffirmations = true;

  final Map<String, List<String>> _faithAffirmations = {
    'christian': [
      '"I can do all things through Christ who strengthens me."\n- Philippians 4:13',
      '"For I know the plans I have for you, declares the Lord, plans to prosper you and not to harm you, plans to give you hope and a future."\n- Jeremiah 29:11',
      '"The Lord is my shepherd; I shall not want."\n- Psalm 23:1',
    ],
    'muslim': [
      '"So verily, with the hardship, there is relief."\n- Quran 94:6',
      '"And He found you lost and guided [you]."\n- Quran 93:7',
      '"Indeed, Allah is with the patient."\n- Quran 2:153',
    ],
    'neutral': [
      'You are resilient and capable of overcoming any challenge.',
      'Every day is a new beginning. Embrace it with hope and courage.',
      'You are enough, just as you are. Believe in your journey.',
    ],
  };

  @override
  void initState() {
    super.initState();
    _fetchFaithPreference();
  }

  Future<void> _fetchFaithPreference() async {
    setState(() {
      _loadingAffirmations = true;
    });
    try {
      final api = ApiService();
      final profile = await api.getProfile();
      final userData = profile['data'] ?? profile;
      final String? faithPref = userData['faith_preference'] ?? userData['faithPreference'];
      String faith = 'neutral';
      if (faithPref != null) {
        final f = faithPref.toLowerCase();
        if (f.contains('christian')) faith = 'christian';
        else if (f.contains('muslim')) faith = 'muslim';
      }
      setState(() {
        _faith = faith;
        _affirmations = _faithAffirmations[faith]!;
        _currentAffirmation = _affirmations[0];
        _loadingAffirmations = false;
      });
    } catch (e) {
      setState(() {
        _faith = 'neutral';
        _affirmations = _faithAffirmations['neutral']!;
        _currentAffirmation = _affirmations[0];
        _loadingAffirmations = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Green appbar
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
          // Body with daily affirmation and other content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Daily affirmation card
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
                    child: _loadingAffirmations
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              // Top row: spark icon, text, refresh button
                              Row(
                                children: [
                                  Icon(
                                    Icons.flash_on,
                                    color: const Color(0xFF2E683D),
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
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // Cycle to next affirmation
                                        final currentIdx = _affirmations.indexOf(_currentAffirmation);
                                        final nextIdx = (currentIdx + 1) % _affirmations.length;
                                        _currentAffirmation = _affirmations[nextIdx];
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
                              // Affirmation text (2 lines)
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
                      'Coping with family pressure and finding peace in community support. Explore recommended readings and groups.',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
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
