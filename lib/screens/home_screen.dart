
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Fertipath/flutter_gen/gen_l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';
import '../models/user.dart';
import 'profile/profile_screen.dart';
import 'support/support_screen.dart';
import 'tracking/log_symptom_screen.dart';
import 'onboarding/welcome_screen.dart';
import 'educational/educational_hub_screen.dart';
import 'calendar_tab_screen.dart';
import 'gender_prediction_screen.dart';
import '../services/insights_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
    Map<String, dynamic>? _insightData;
    String? _insightText;

    // Default fallback data
    static const Map<String, dynamic> _defaultCycleSummary = {
      'fertile_period_start': 'N/A',
      'fertile_period_end': 'N/A',
      'ovulation_day': 'N/A',
    };
    static const String _defaultInsightText =
        'Track your cycle and get personalized insights here. Once you log your symptoms and cycle data, helpful tips and predictions will appear!';
  // String? _fertileWindowText; // Removed, now handled in CalendarTabScreen
  int _selectedIndex = 0;
  bool _showSideMenu = false;
  final ValueNotifier<bool> _calendarRefreshNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    // _loadFertileWindow(); // Removed, now handled in CalendarTabScreen
    _sendInsightsPost();
  }

  Future<void> _sendInsightsPost() async {
    try {
      final api = ApiService();
      final headers = await api.getHeaders(includeAuth: true);
      // Fetch user profile to get period_length, cycle_length, last_period_date
      Map<String, dynamic>? profile;
      try {
        profile = await api.getProfile();
      } catch (e) {
        // If fetching profile fails, show dialog to set up profile
        if (mounted) {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Text('Profile Required'),
              content: const Text('You need to set up your profile before using this feature.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    );
                  },
                  child: const Text('Set Up Profile'),
                ),
              ],
            ),
          );
        }
        // Show fallback data
        setState(() {
          _insightData = Map<String, dynamic>.from(_defaultCycleSummary);
          _insightText = _defaultInsightText;
        });
        return;
      }
      int? cycleLength;
      int? periodLength;
      String? lastPeriodDate;
      if (profile != null) {
        cycleLength = profile['cycle_length'] is int ? profile['cycle_length'] : int.tryParse(profile['cycle_length']?.toString() ?? '');
        periodLength = profile['period_length'] is int ? profile['period_length'] : int.tryParse(profile['period_length']?.toString() ?? '');
        lastPeriodDate = profile['last_period_date']?.toString();
      }
      final url = Uri.parse('${ApiService.baseUrl}/insights/insights');
      final body = {
        'cycle_length': cycleLength ?? 0,
        'last_period_date': lastPeriodDate ?? '',
        'period_length': periodLength ?? 0,
        'symptoms': ['none'],
      };
      await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      // Now GET insights/insights
      final getResponse = await http.get(url, headers: headers);
      if (getResponse.statusCode == 200) {
        final List<dynamic> data = jsonDecode(getResponse.body);
        if (data.isNotEmpty && data[0] is Map<String, dynamic>) {
          setState(() {
            _insightData = data[0];
            _insightText = data[0]['insight_text']?.toString() ?? _defaultInsightText;
          });
          return;
        }
      }
      // If no data or bad response, show fallback
      setState(() {
        _insightData = Map<String, dynamic>.from(_defaultCycleSummary);
        _insightText = _defaultInsightText;
      });
    } catch (e) {
      debugPrint('Failed to send/get insights: $e');
      setState(() {
        _insightData = Map<String, dynamic>.from(_defaultCycleSummary);
        _insightText = _defaultInsightText;
      });
    }
  }

  @override
  void dispose() {
    _calendarRefreshNotifier.dispose();
    super.dispose();
  }

  // Removed _loadFertileWindow and related state, now handled in CalendarTabScreen

  // Removed _fetchInsight and related state

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
              CalendarTabScreen(refreshNotifier: _calendarRefreshNotifier),
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
                            label: 'Profile',
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
    final auth = Provider.of<AuthService>(context);
    final user = auth.currentUser;

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
                        // ... other positioned widgets ...
                        if (_insightText != null && _insightText!.isNotEmpty)
                          Positioned(
                            bottom: 100,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Today's Fertility Insight",
                                    style: const TextStyle(
                                      fontSize: 30,
                                      color: Color(0xFFA8D497), // light green
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _insightText!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        // Hamburger menu icon
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
                          setState(() {
                            _selectedIndex = 2; // Calendar tab
                          });
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Cycle summary table (below hero section)
          if (_insightData != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Table(
                border: TableBorder.all(color: Colors.white, width: 1),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Fertile Window', style: TextStyle(color: Color(0xFF2E683D), fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_insightData!['fertile_period_start'] != null && _insightData!['fertile_period_end'] != null
                          ? '${_insightData!['fertile_period_start']} - ${_insightData!['fertile_period_end']}'
                          : '-',
                        style: const TextStyle(color: Color(0xFF2E683D)),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Ovulation Day', style: TextStyle(color: Color(0xFF2E683D), fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_insightData!['ovulation_day'] ?? '-', style: const TextStyle(color: Color(0xFF2E683D))),
                    ),
                  ]),
                ],
              ),
            ),
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

