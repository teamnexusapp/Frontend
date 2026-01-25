import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
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
import 'user_guide_screen.dart';
import 'specialists/specialist_search_screen.dart';
import 'specialists/specialist_chat_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
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
  
  int _selectedIndex = 0;
  bool _showSideMenu = false;

  @override
  void initState() {
    super.initState();
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
        // If fetching profile fails, show fallback data
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
        cycleLength = profile['cycle_length'] is int 
            ? profile['cycle_length'] 
            : int.tryParse(profile['cycle_length']?.toString() ?? '');
        periodLength = profile['period_length'] is int 
            ? profile['period_length'] 
            : int.tryParse(profile['period_length']?.toString() ?? '');
        lastPeriodDate = profile['last_period_date']?.toString();
      }
      
      final url = Uri.parse('${ApiService.baseUrl}/insights/insights');
      final body = {
        'cycle_length': cycleLength ?? 0,
        'last_period_date': lastPeriodDate ?? '',
        'period_length': periodLength ?? 0,
        'symptoms': ['none'],
      };
      
      debugPrint('Sending POST to /insights/insights with body: $body');
      final postResponse = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      debugPrint('POST response status: ${postResponse.statusCode}');
      
      // Now GET insights/insights
      final getResponse = await http.get(url, headers: headers);
      debugPrint('GET /insights/insights status: ${getResponse.statusCode}');
      debugPrint('GET /insights/insights response: ${getResponse.body}');
      
      if (getResponse.statusCode == 200) {
        final List<dynamic> data = jsonDecode(getResponse.body);
        debugPrint('Parsed insights data: $data');
        
        if (data.isNotEmpty && data[0] is Map<String, dynamic>) {
          final insights = data[0] as Map<String, dynamic>;
          debugPrint('First insight object keys: ${insights.keys.toList()}');
          
          setState(() {
            _insightData = insights;
            // Try to get insight_text, or generate one from available data
            _insightText = insights['insight_text']?.toString() ?? 
                           insights['prediction']?.toString() ??
                           insights['recommendation']?.toString() ??
                           _defaultInsightText;
            debugPrint('Set _insightText to: $_insightText');
          });
          return;
        }
      }
      
      // If no data or bad response, show fallback
      debugPrint('No valid insights data, using fallback');
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
              const EducationalHubScreen(),
              const CalendarTabScreen(),
              const SupportScreen(),
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
                  width: MediaQuery.of(context).size.width * 0.6,
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
                            onTap: () async {
                              _toggleSideMenu();
                              final result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const ProfileScreen(),
                                ),
                              );
                              // Refresh home page data if profile was updated
                              if (result == true) {
                                _sendInsightsPost();
                              }
                            },
                          ),
                          _buildMenuItem(
                            label: 'Support',
                            icon: Icons.help_outline,
                            onTap: () {
                              _toggleSideMenu();
                              _showSupportDialog();
                            },
                          ),
                          _buildMenuItem(
                            label: 'How to Use',
                            icon: Icons.menu_book_outlined,
                            onTap: () {
                              _toggleSideMenu();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const UserGuideScreen(),
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
            label: _selectedIndex == 0 ? 'Home' : '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.school),
            label: _selectedIndex == 1 ? 'Learn' : '',
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
          fontSize: radius * 0.8,
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

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2E683D),
            ),
          ),
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

  Widget _buildHomeTab() {
    final size = MediaQuery.of(context).size;
    final heroHeight = size.height * 0.5;
    const buttonHeight = 64.0;
    
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
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
                        // Hamburger menu icon
                        Positioned(
                          top: 30,
                          left: 0,
                          child: GestureDetector(
                            onTap: _toggleSideMenu,
                            child: const Icon(
                              Icons.menu,
                              color: Color(0xFFA8D497),
                              size: 28,
                            ),
                          ),
                        ),
                        // Decorative semicolon
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
                                  fontSize: 280,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Insight text
                        if (_insightText != null && _insightText!.isNotEmpty)
                          Positioned(
                            bottom: 80,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Today's Fertility Insight",
                                    style: TextStyle(
                                      fontSize: 28,
                                      color: Color(0xFFA8D497),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    _insightText!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                    ),
                                    textAlign: TextAlign.left,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
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
                          setState(() {
                            _selectedIndex = 2; // Navigate to Calendar tab
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
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF2E683D).withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cycle Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2E683D),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSummaryRow(
                      'Fertile Window',
                      _insightData!['fertile_period_start'] != null && 
                          _insightData!['fertile_period_end'] != null
                          ? '${_insightData!['fertile_period_start']} - ${_insightData!['fertile_period_end']}'
                          : 'N/A',
                    ),
                    const Divider(),
                    _buildSummaryRow(
                      'Ovulation Day',
                      _insightData!['ovulation_day']?.toString() ?? 'N/A',
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 16),
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
                      MaterialPageRoute(builder: (_) => const GenderPredictionScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFeatureCard(
                  icon: Icons.medical_services_outlined,
                  label: 'Find\nSpecialist',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SpecialistSearchScreen()),
                    );
                  },
                ),
                const SizedBox(width: 12),
                _buildFeatureCard(
                  icon: Icons.chat_bubble_outline,
                  label: 'Chat with\nSpecialist',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SpecialistChatScreen()),
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

  void _showSupportDialog() {
    final TextEditingController _messageController = TextEditingController();
    bool _isLoading = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: Text(
                'Send us your feedback',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Let us know about any concerns, bugs, or suggestions:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _messageController,
                      maxLines: 5,
                      minLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Describe your feedback...',
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          if (_messageController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter your feedback'),
                              ),
                            );
                            return;
                          }

                          setState(() => _isLoading = true);

                          try {
                            // Send email via backend or email service
                            final auth = Provider.of<AuthService>(context, listen: false);
                            final user = auth.currentUser;
                            final userEmail = user?.email ?? 'No email';

                            // Using simple mailto approach with additional backend call
                            final subject = 'Support Feedback from $userEmail';
                            final body = '''
Feedback from: $userEmail

Message:
${_messageController.text}
''';

                            // Provide support email and copy it for the user
                            try {
                              final apiService = ApiService();
                              final supportEmail = await apiService.getSupportEmail();
                              await Clipboard.setData(ClipboardData(text: supportEmail));
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Support email copied: $supportEmail'),
                                  ),
                                );
                              }
                            } catch (apiError) {
                              debugPrint('Error getting support email: $apiError');
                            }

                            if (mounted) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please send your feedback to teamnexus@techlaunchpadi',
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          } catch (e) {
                            debugPrint('Error sending support message: $e');
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error sending feedback: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } finally {
                            if (mounted) {
                              setState(() => _isLoading = false);
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E683D),
                    foregroundColor: Colors.white,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Send',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
