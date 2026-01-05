import 'package:flutter/material.dart';
import './_next_period_prediction_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth_service.dart';
import '../../models/user.dart';
import '../../services/localization_provider.dart';
import '../../services/api_service.dart';

import '../onboarding/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = true;
  User? _user;
  User? _userCard;
  bool _isDeleting = false;

  // Add missing fields for preferences
  String selectedLanguage = 'English';
  bool faithBasedContent = false;
  String selectedTheme = 'Light';

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _loadUserCard();
  }

  Future<void> _loadUserProfile() async {
    try {
      final apiService = ApiService();
      final profileJson = await apiService.getProfile();
      debugPrint('Profile JSON received: ' + profileJson.toString());
      final fetchedUser = User.fromJson(profileJson);
      debugPrint('Parsed User: ttcHistory=' + (fetchedUser.ttcHistory?.toString() ?? 'null') +
          ', faithPreference=' + (fetchedUser.faithPreference?.toString() ?? 'null') +
          ', cycleLength=' + (fetchedUser.cycleLength?.toString() ?? 'null') +
          ', lastPeriodDate=' + (fetchedUser.lastPeriodDate?.toString() ?? 'null'));
      setState(() {
        _user = fetchedUser;
        if (_user != null) {
          selectedLanguage = _getLanguageDisplayName(_user!.preferredLanguage ?? 'en');
        }
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading profile: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadUserCard() async {
    try {
      final apiService = ApiService();
      final userJson = await apiService.getUser();
      debugPrint('getUser JSON received: ' + userJson.toString());
      final fetchedUser = User.fromJson(userJson);
      setState(() {
        _userCard = fetchedUser;
      });
    } catch (e) {
      debugPrint('Error loading getUser for card: $e');
    }
  }

  String _getLanguageDisplayName(String code) {
    switch (code.toLowerCase()) {
      case 'en': return 'English';
      case 'ig': return 'Igbo';
      case 'ha': return 'Hausa';
      case 'yo': return 'Yoruba';
      case 'fr': return 'French';
      case 'pt': return 'Portuguese';
      case 'es': return 'Spanish';
      default: return 'English';
    }
  }

  // Removed local period/cycle prediction logic. Use backend values only.

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final loc = Provider.of<LocalizationProvider>(context);
    final user = _user ?? auth.currentUser;
    final userCard = _userCard ?? auth.currentUser;

    // Get calendar days from CalendarTabScreen (for demo, use SharedPreferences directly)
    // In production, refactor to pass calendar data via provider or callback
    final Set<DateTime> calendarDays = {};
    // Load tapped days from SharedPreferences synchronously (for demo only)
    // In production, this should be async and handled in state
    // This is a workaround for demonstration
    SharedPreferences.getInstance().then((prefs) {
      final savedDays = prefs.getStringList('tapped_days');
      if (savedDays != null && savedDays.isNotEmpty) {
        calendarDays.addAll(savedDays.map((s) => DateTime.parse(s)));
      }
    });
    // Removed local prediction. Use backend-provided next period dates only.

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D5A3A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Profile & Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2D5A3A)),
              ),
            )
          : RefreshIndicator(
              onRefresh: _loadUserProfile,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // User Profile Card (always use get_user)
                    _buildProfileCard(userCard, context),
                    const SizedBox(height: 16),
                    // Removed nextPeriodDates display. Use backend-driven widgets only.
                    // Goals Section
                    _buildGoalsSection(),
                    const SizedBox(height: 16),
                    // Preferences Section
                    _buildPreferencesSection(),
                    const SizedBox(height: 16),
                    // Privacy & Security Section
                    _buildPrivacySection(),
                    const SizedBox(height: 16),
                    // Delete Account Section
                    _buildDeleteAccountSection(context),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildProfileCard(user, BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                _buildInitialAvatar(user),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (() {
                          final fullName = [user?.firstName, user?.lastName]
                              .where((part) => part != null && part!.trim().isNotEmpty)
                              .map((part) => part!.trim())
                              .join(' ');
                          if (fullName.isNotEmpty) return fullName;
                          if (user?.username != null && user!.username!.trim().isNotEmpty) {
                            return user.username!.trim();
                          }
                          if (user?.email != null && user!.email.trim().isNotEmpty) {
                            return user.email.split('@').first;
                          }
                          return 'User';
                        })(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        (user?.email != null && user!.email.trim().isNotEmpty)
                            ? user.email
                            : 'No email',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      if (user?.phoneNumber != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          user!.phoneNumber!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed('/onboarding/profile');
                // After returning from profile setup, reload profile to fetch new goal values
                await _loadUserProfile();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4E9D7),
                foregroundColor: const Color(0xFF2D5A3A),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_outline, size: 20),
                  SizedBox(width: 8),
                  Text('Set and update profile', style: TextStyle(fontWeight: FontWeight.w600)),
                  Spacer(),
                  Icon(Icons.chevron_right, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialAvatar(User? user) {
    final fullName = [user?.firstName, user?.lastName]
      .where((part) => part != null && part!.trim().isNotEmpty)
      .map((part) => part!.trim())
      .join(' ');
    final fallbackName = (user?.username != null && user!.username!.trim().isNotEmpty)
      ? user.username!.trim()
      : ((user?.email != null && user!.email.trim().isNotEmpty)
        ? user.email.split('@').first
        : 'U');
    final displayName = fullName.isNotEmpty ? fullName : fallbackName;
    final initial = displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U';
    final bgColor = _colorFromString(displayName.isNotEmpty ? displayName : initial);

    return CircleAvatar(
      radius: 35,
      backgroundColor: bgColor,
      child: Text(
        initial,
        style: const TextStyle(
          fontSize: 24,
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

  Widget _buildGoalsSection() {
    // Dynamically display user profile data fetched from API
    if (_isLoading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.favorite_border, size: 20, color: Colors.grey[700]),
                const SizedBox(width: 8),
                Text(
                  _user?.ttcHistory ?? 'Not set',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildGoalRow('Faith Preference', _user?.faithPreference ?? 'Not set'),
            const SizedBox(height: 12),
            _buildGoalRow('Cycle Length',
              _user?.cycleLength != null ? '${_user!.cycleLength} days' : 'Not set'),
            const SizedBox(height: 12),
            _buildGoalRow('Last Period Date',
              _user?.lastPeriodDate != null ? _user!.lastPeriodDate.toString().split(' ')[0] : 'Not set'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildPreferencesSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preference',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16),
            _buildLanguageRow(),
            const Divider(height: 24),
            _buildFaithBasedRow(),
            const Divider(height: 24),
            _buildThemeRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageRow() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE6F4EA), // light green
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(Icons.language, size: 22, color: Color(0xFF2D5A3A)), // dark green
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'Language',
            style: TextStyle(fontSize: 15),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(6),
          ),
          child: DropdownButton<String>(
            value: selectedLanguage,
            underline: const SizedBox(),
            isDense: true,
            items: ['English', 'Igbo', 'Hausa', 'Yoruba']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(fontSize: 14)),
              );
            }).toList(),
            onChanged: (String? newValue) async {
              if (newValue == null) return;
              setState(() {
                selectedLanguage = newValue;
              });
              // Map display name to code
              String code = 'en';
              switch (newValue) {
                case 'English': code = 'en'; break;
                case 'Igbo': code = 'ig'; break;
                case 'Hausa': code = 'ha'; break;
                case 'Yoruba': code = 'yo'; break;
              }
              try {
                await ApiService().updateLanguage(code);
              } catch (e) {
                debugPrint('Failed to update language: $e');
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFaithBasedRow() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE6F4EA), // light green
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(Icons.lightbulb_outline, size: 22, color: Color(0xFF2D5A3A)), // dark green
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'Faith-based content',
            style: TextStyle(fontSize: 15),
          ),
        ),
        Switch(
          value: faithBasedContent,
          onChanged: (bool value) {
            setState(() {
              faithBasedContent = value;
            });
          },
          activeColor: const Color(0xFF2D5A3A),
        ),
      ],
    );
  }

  Widget _buildThemeRow() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE6F4EA), // light green
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(Icons.brightness_6_outlined, size: 22, color: Color(0xFF2D5A3A)), // dark green
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'App Theme',
            style: TextStyle(fontSize: 15),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(6),
          ),
          child: DropdownButton<String>(
            value: selectedTheme,
            underline: const SizedBox(),
            isDense: true,
            items: ['Light', 'Dark', 'System']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(fontSize: 14)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedTheme = newValue!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacySection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy & Security',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.shield_outlined, color: Color(0xFF2D5A3A)), // dark green
              title: const Text('Data Privacy Policy'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to privacy policy
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.shield_outlined, color: Color(0xFF4CAF50)), // medium green
              title: const Text('Manage Data & Permissions'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to data management
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.shield_outlined, color: Color(0xFF81C784)), // light green
              title: const Text('Explore my Data'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to data exploration
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteAccountSection(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delete Account',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Once you delete your account, there is no going back. This action is permanent and cannot be undone.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isDeleting
                    ? null
                    : () async {
                        setState(() => _isDeleting = true);
                        try {
                          await ApiService().deleteUser();
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Account deleted successfully.'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            // Navigate to WelcomeScreen
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                              (route) => false,
                            );
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to delete account: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } finally {
                          if (mounted) setState(() => _isDeleting = false);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: _isDeleting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Delete my Account',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _showDeleteConfirmation removed; delete account feature is now disabled.
}


