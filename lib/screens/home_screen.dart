import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nexus_fertility_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../services/auth_service.dart';
import 'profile/profile_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _showSideMenu = false;
  int? _selectedCalendarDay;

  void _toggleSideMenu() {
    setState(() {
      _showSideMenu = !_showSideMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: [
              _buildHomeTab(),
              _buildLearnHubTab(),
              _buildCalendarTab(),
              _buildCommunityTab(),
            ],
          ),
          // Side menu overlay
          if (_showSideMenu)
            GestureDetector(
              onTap: _toggleSideMenu,
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          // Side menu
          if (_showSideMenu)
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {}, // Prevent closing when tapping inside menu
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Color(0xFFA8D497),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Color(0xFF2E683D),
                              size: 28,
                            ),
                            onPressed: _toggleSideMenu,
                            padding: EdgeInsets.zero,
                            alignment: Alignment.centerLeft,
                          ),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: () {
                              _toggleSideMenu();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const ProfileScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Settings',
                              style: TextStyle(
                                color: Color(0xFF2E683D),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF2E683D),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: _selectedIndex == 0 ? AppLocalizations.of(context)!.home : '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.school),
            label: _selectedIndex == 1 ? AppLocalizations.of(context)!.learn : '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.timeline),
            label: _selectedIndex == 2 ? 'Track' : '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: _selectedIndex == 3 ? 'Community' : '',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    final size = MediaQuery.of(context).size;
    final heroHeight = size.height * 0.5;
    const buttonHeight = 64.0;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: heroHeight + (buttonHeight / 2),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: heroHeight,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2E683D),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Stack(
                      children: [
                        // Decorative semicolon background
                        Positioned(
                          bottom: 50,
                          right: -40,
                          child: Transform.rotate(
                            angle: -0.3, // ~17 degrees tilt
                            child: Opacity(
                              opacity: 0.15,
                              child: Text(
                                ';',
                                style: TextStyle(
                                  fontSize: 320,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          left: 15,
                          child: GestureDetector(
                            onTap: _toggleSideMenu,
                            child: const Icon(
                              Icons.menu,
                              color: Color(0xFFA8D497),
                              size: 28,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 70, left: 30),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Today's fertility\ninsight",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    color: Color(0xFFA8D497),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Your next fertility\nwindow is from\nDec 23-27',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: heroHeight - (buttonHeight / 2),
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                      width: 280,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA8D497),
                          foregroundColor: const Color(0xFF2E683D),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.water_drop, color: Color(0xFF2E683D)),
                            SizedBox(width: 12),
                            Text(
                              'Log symptoms',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                color: Color(0xFF2E683D),
                              ),
                            ),
                            SizedBox(width: 12),
                            Icon(Icons.arrow_right, color: Color(0xFF2E683D)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Encouragement text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "You're doing great! Stay positive\nand be focused!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
                color: Color(0xFF2E683D),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 15),
          // Feature cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFeatureCard(
                  icon: Icons.calendar_today,
                  label: 'Calendar',
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1; // Navigate to calendar tab
                    });
                  },
                ),
                const SizedBox(width: 12),
                _buildFeatureCard(
                  icon: Icons.child_care,
                  label: 'Gender\nPredictions',
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 141,
        height: 120,
        decoration: BoxDecoration(
          color: const Color(0xFF2E683D),
          borderRadius: BorderRadius.zero,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFFA8D497),
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: Color(0xFFA8D497),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarTab() {
    final size = MediaQuery.of(context).size;
    final greenHeight = size.height * 0.5;
    
    return Scaffold(
      backgroundColor: const Color(0xFF2E683D),
      body: Stack(
        children: [
          // Top green area with calendar header
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back arrow
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0; // Navigate to home
                      });
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Month and year centered
                  Center(
                    child: const Text(
                      'December 2025',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Day labels row with horizontal padding and 2px gap below
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('S', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'Poppins')),
                        Text('M', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'Poppins')),
                        Text('T', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'Poppins')),
                        Text('W', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'Poppins')),
                        Text('T', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'Poppins')),
                        Text('F', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'Poppins')),
                        Text('S', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'Poppins')),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Calendar grid
                  _buildCalendarGridInGreen(),
                ],
              ),
            ),
          ),
          // White container from middle to bottom
          Positioned(
            top: greenHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Cycle summaries
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Cycle summaries',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildCycleSummary(),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.loggedSymptoms,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildLoggedSymptomItem(AppLocalizations.of(context)!.bleeding, 7),
                    _buildLoggedSymptomItem(AppLocalizations.of(context)!.mood, 14),
                    _buildLoggedSymptomItem(AppLocalizations.of(context)!.cervicalMucus, 21),
                    _buildLoggedSymptomItem(AppLocalizations.of(context)!.pain, 28),
                    _buildLoggedSymptomItem(AppLocalizations.of(context)!.notes, 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCycleSummary() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          // Row 1: Abnormalities
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Abnormalities',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'None',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF2E683D),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Row 2: Fertile window
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Fertile window',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '21st - 27 Dec',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Row 3: Gender specific
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Fertile Window (Gender specific)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '—',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Row 4: AI insights
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFA8D497),
                ),
                child: const Center(
                  child: Icon(
                    Icons.smart_toy,
                    size: 14,
                    color: Color(0xFF2E683D),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'AI',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF2E683D),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.lock,
                size: 16,
                color: Colors.grey.shade500,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Unlock detailed insights and chat with verified doctors',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGridInGreen() {
    // December 2025 starts on Monday (day 1), so Sunday (0) is from previous month
    final startDay = 1; // 0=Sunday, 1=Monday for Dec 1
    final daysInMonth = 31;
    final daysInPrevMonth = 30; // November has 30 days
    
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: 35,
        itemBuilder: (context, index) {
          if (index < startDay) {
            // Previous month days
            final prevDay = daysInPrevMonth - startDay + index + 1;
            return Center(
              child: Text(
                '$prevDay',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
            );
          } else if (index < startDay + daysInMonth) {
            // Current month days
            final day = index - startDay + 1;
            final bool isSelected = _selectedCalendarDay == day;
            return Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCalendarDay = day;
                  });
                },
                child: Container
                (
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? const Color(0xFFA8D497) : Colors.transparent,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$day',
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? const Color(0xFF2E683D) : Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final days = List.generate(31, (i) => i + 1);
    const dayLabels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Column(
      children: [
        // Day labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: dayLabels
              .map((day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 12),
        // Calendar days
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 35,
          itemBuilder: (context, index) {
            final day = index - 1;
            if (day < 0 || day >= 31) {
              return const SizedBox();
            }
            return Container(
              decoration: BoxDecoration(
                color: day + 1 == 23
                    ? Colors.blue.shade400
                    : day + 1 > 23
                        ? Colors.grey.shade200
                        : Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '${day + 1}',
                  style: TextStyle(
                    fontSize: 14,
                    color: day + 1 == 23 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLoggedSymptomItem(String symptom, int day) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.grey.shade400, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              symptom,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Text(
            '$day',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildLearnHubTab() {
    final filters = ['Fertility basics', 'Myths & Facts', 'Trying to conceive'];
    int activeFilter = 0;

    return StatefulBuilder(
      builder: (context, setState) {
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
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    _buildArticleCard(
                      title: "Infertility isn't a curse",
                      description:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      category: 'Fertility basics',
                      duration: '5 minutes read',
                    ),
                    const SizedBox(height: 16),
                    _buildArticleCard(
                      title: 'Understanding Your Fertility Cycle',
                      description:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      category: 'Trying to conceive',
                      duration: '4 minutes read',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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

  Widget _buildQuickActionCard(
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.black),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSymptomCard(String label, IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey.shade600),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunityTab() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite,
              size: 64,
              color: const Color(0xFF2E683D),
            ),
            const SizedBox(height: 16),
            Text(
              'Community',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Color(0xFF2E683D),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Coming soon',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

