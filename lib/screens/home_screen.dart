import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nexus_fertility_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../models/user.dart';
import 'profile/profile_screen.dart';
import 'support/support_screen.dart';
import 'tracking/log_symptom_screen.dart';
import 'onboarding/welcome_screen.dart';
import 'educational/educational_hub_screen.dart';
import 'calendar_tab_screen.dart';
import 'gender_prediction/gender_prediction_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _showSideMenu = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final user = auth.currentUser;
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: [
              _buildHomeTab(),
              EducationalHubScreen(),
              CalendarTabScreen(),
              SupportScreen(),
            ],
          ),
          if (_showSideMenu)
            GestureDetector(
              onTap: _toggleSideMenu,
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          if (_showSideMenu)
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Color(0xFFA8D497),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 30, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              _buildAvatar(user),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildProfileCard(user),
                          const SizedBox(height: 20),
                          _buildMenuItem(
                            label: 'Profile & Settings',
                            icon: Icons.person_outline,
                            onTap: () {
                              _toggleSideMenu();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const ProfileScreen(),
                                ),
                              );
                            },
                          ),
                          _buildMenuItem(
                            label: 'Support',
                            icon: Icons.help_outline,
                            onTap: () {
                              _toggleSideMenu();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const SupportScreen(),
                                ),
                              );
                            },
                          ),
                          const Spacer(),
                          _buildMenuItem(
                            label: 'Log out',
                            icon: Icons.logout,
                            iconColor: Colors.grey.shade600,
                            textColor: Colors.grey.shade700,
                            onTap: () async {
                              _toggleSideMenu();
                              await auth.signOut();
                              if (mounted) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                                  (route) => false,
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 12),
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
            icon: const Icon(Icons.support_agent),
            label: _selectedIndex == 3 ? 'Support' : '',
          ),
        ],
      ),
    );
  }

  void _toggleSideMenu() {
    setState(() {
      _showSideMenu = !_showSideMenu;
    });
  }

  Widget _buildProfileCard(User? user) {
    final fullName = [user?.firstName, user?.lastName]
        .where((part) => part != null && part!.trim().isNotEmpty)
        .map((part) => part!.trim())
        .join(' ');
    final fallbackName = (user?.username != null && user!.username!.trim().isNotEmpty)
        ? user.username!.trim()
        : ((user?.email != null && user!.email.trim().isNotEmpty)
            ? user.email.split('@').first
            : 'User');
    final displayName = fullName.isNotEmpty ? fullName : fallbackName;
    final email = (user?.email != null && user!.email.trim().isNotEmpty) ? user.email : 'No email';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildAvatar(user, radius: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2E683D),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? const Color(0xFF2E683D), size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: textColor ?? const Color(0xFF2E683D),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(User? user, {double radius = 18}) {
    final fullName = [user?.firstName, user?.lastName]
      .where((part) => part != null && part!.trim().isNotEmpty)
      .map((part) => part!.trim())
      .join(' ');
    final fallbackName = (user?.username != null && user!.username!.trim().isNotEmpty)
      ? user.username!.trim()
      : ((user?.email != null && user!.email.trim().isNotEmpty)
        ? user.email.split('@').first
        : 'U');
    final nameForInitial = fullName.isNotEmpty ? fullName : fallbackName;
    final initial = nameForInitial.isNotEmpty ? nameForInitial[0].toUpperCase() : 'U';
    final color = _colorFromString(nameForInitial.isNotEmpty ? nameForInitial : initial);

    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: Text(
        initial,
        style: TextStyle(
          fontSize: radius,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Color _colorFromString(String input) {
    if (input.isEmpty) return const Color(0xFF2E683D);
    final hash = input.codeUnits.fold<int>(0, (prev, code) => prev + code);
    final hue = (hash % 360).toDouble();
    return HSVColor.fromAHSV(1, hue, 0.45, 0.85).toColor();
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
                        Positioned(
                          bottom: 50,
                          right: -40,
                          child: Transform.rotate(
                            angle: -0.3,
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
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const CalendarTabScreen(),
                            ),
                          );
                        },
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
                      _selectedIndex = 2;
                    });
                  },
                ),
                const SizedBox(width: 12),
                _buildFeatureCard(
                  icon: Icons.child_care,
                  label: 'Gender\nPredictions',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => GenderPredictionScreen()),
                    );
                  },
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
}

