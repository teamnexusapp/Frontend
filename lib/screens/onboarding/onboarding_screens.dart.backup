import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/localization_provider.dart' as loc_provider;
import 'language_selection_screen.dart';
import 'phone_signup_screen.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToRegister();
    }
  }

  void _navigateToRegister() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const PhoneSignupScreen()),
    );
  }

  String _getSelectedLanguageName(BuildContext context) {
    final provider = context.read<loc_provider.LocalizationProvider>();
    final code = provider.locale.languageCode;
    switch (code) {
      case 'en':
        return 'English';
      case 'ig':
        return 'Igbo';
      case 'yo':
        return 'Yoruba';
      case 'ha':
        return 'Hausa';
      default:
        return 'English';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const LanguageSelectionScreen(),
                        ),
                      );
                    },
                    child: Text(
                      _getSelectedLanguageName(context),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _navigateToRegister,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        color: Color(0xFFA8D497),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // PageView Content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildFirstScreen(),
                  _buildSecondScreen(),
                  _buildThirdScreen(),
                ],
              ),
            ),

            // Next Button
            Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: SizedBox(
                width: 361,
                height: 56,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E683D),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(int index) {
    final isActive = _currentPage == index;
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        width: isActive ? 32 : 8,
        height: 8,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFA8D497) : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildFirstScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Calendar Icon in Circle
            Container(
              width: 128,
              height: 128,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFA8D497),
              ),
              child: const Icon(
                Icons.calendar_today,
                size: 64,
                color: Color(0xFF2E683D),
              ),
            ),
            const SizedBox(height: 24),

            // Title
            const Text(
              'Track your Cycle',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Paragraph
            const Text(
              'Monitor your cycle with ease and get personalised insight',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),

            // Page Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIndicator(0),
                const SizedBox(width: 3),
                _buildIndicator(1),
                const SizedBox(width: 3),
                _buildIndicator(2),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Book Icon in Circle
            Container(
              width: 128,
              height: 128,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFA8D497),
              ),
              child: const Icon(
                Icons.book_outlined,
                size: 64,
                color: Color(0xFF2E683D),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Learn in your own language',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            const Text(
              'Access fertility education and resources in the language you understand best',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),

            // Page Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIndicator(0),
                const SizedBox(width: 3),
                _buildIndicator(1),
                const SizedBox(width: 3),
                _buildIndicator(2),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThirdScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Heart/Love Icon in Circle
            Container(
              width: 128,
              height: 128,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFA8D497),
              ),
              child: const Icon(
                Icons.favorite_border,
                size: 64,
                color: Color(0xFF2E683D),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Feel supported',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            const Text(
              'Join a caring community and get the support you need on your journey',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),

            // Page Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIndicator(0),
                const SizedBox(width: 3),
                _buildIndicator(1),
                const SizedBox(width: 3),
                _buildIndicator(2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
