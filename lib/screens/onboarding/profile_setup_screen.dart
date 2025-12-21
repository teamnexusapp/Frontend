import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nexus_fertility_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../services/auth_service.dart';

import '../../services/auth_error_helper.dart';
import '../../services/localization_provider.dart';


class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  int _age = 27;
  int _cycleLength = 28;
  DateTime? _lastPeriodDate;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String? _ttcHistory;
  String? _faithPreference;
  String _languageCode = 'en';
  bool _audioGuidance = false;
  bool _isLoading = false;
  bool _acceptTerms = false;

  final List<String> _ttcHistories = [
    'Trying to Conceive',
    'Trying to Conceive - Default',
    'Preparing to conceive',
    'Just tracking my cycle',
    'TTC 6+ months',
    'TTC 12+ months',
    'Using fertility treatment',
    'Prefer not to say'
  ];

  final List<String> _faithPreferences = [
    'Christian',
    'Muslim',
    'Jewish',
    'None'
  ];

  // Language options are built in build() to ensure labels are localized

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(

          AppLocalizations.of(context)!.profile,

          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: 0.9,
                  minHeight: 4,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blue.shade400,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Title
              Text(
                AppLocalizations.of(context)!.completeProfile,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.personalizeGuide,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 32),

                  // First / Last name
                  _buildFieldLabel(AppLocalizations.of(context)!.firstName),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(hintText: AppLocalizations.of(context)!.firstName),
                    validator: (v) => (v == null || v.isEmpty) ? 'Enter your first name' : null,
                  ),
                  const SizedBox(height: 16),
                  _buildFieldLabel(AppLocalizations.of(context)!.lastName),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(hintText: AppLocalizations.of(context)!.lastName),
                    validator: (v) => (v == null || v.isEmpty) ? 'Enter your last name' : null,
                  ),
                  const SizedBox(height: 24),

                  // Age
                  _buildFieldLabel(AppLocalizations.of(context)!.age),
                  _buildNumberDropdown(
                    value: _age,
                    items: List.generate(73, (i) => i + 18),
                    onChanged: (value) => setState(() => _age = value),
                  ),
                  const SizedBox(height: 20),

                  // Cycle Length
                  _buildFieldLabel(AppLocalizations.of(context)!.cycleLength),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<int>(
                      value: _cycleLength,
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: List.generate(30, (i) => i + 1).map((days) {
                        return DropdownMenuItem(
                          value: days,
                          child: Text(AppLocalizations.of(context)!.days(days)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _cycleLength = value ?? 28);
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.averageDaysBetweenPeriods,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Last Period Date
                  _buildFieldLabel(AppLocalizations.of(context)!.lastPeriodDate),
                  GestureDetector(
                    onTap: _selectDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.grey.shade600, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _lastPeriodDate == null
                                  ? AppLocalizations.of(context)!.selectDate
                                  : MaterialLocalizations.of(context).formatMediumDate(_lastPeriodDate!),
                              style: TextStyle(
                                fontSize: 16,
                                color: _lastPeriodDate == null
                                    ? Colors.grey.shade600
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.whenLastBleeding,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // TTC History
                  _buildFieldLabel(AppLocalizations.of(context)!.ttcHistory),
                  _buildDropdown(
                    value: _ttcHistory,
                    items: _ttcHistories,
                    onChanged: (value) => setState(() => _ttcHistory = value),
                  ),
                  const SizedBox(height: 20),

                  // Faith Preference
                  _buildFieldLabel(AppLocalizations.of(context)!.faithPreference),
                  _buildDropdown(
                    value: _faithPreference,
                    items: _faithPreferences,
                    onChanged: (value) => setState(() => _faithPreference = value),
                  ),
                  const SizedBox(height: 20),

                  // Language
                  _buildFieldLabel(AppLocalizations.of(context)!.language),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Builder(builder: (ctx) {
                      final provider = Provider.of<LocalizationProvider>(context, listen: false);
                      final options = [
                        {'code': 'en', 'label': AppLocalizations.of(context)!.english},
                        {'code': 'yo', 'label': AppLocalizations.of(context)!.yoruba},
                        {'code': 'ig', 'label': AppLocalizations.of(context)!.igbo},
                        {'code': 'ha', 'label': AppLocalizations.of(context)!.hausa},
                      ];
                      return DropdownButton<String>(
                        value: _languageCode,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: options
                            .map((o) => DropdownMenuItem<String>(
                                  value: o['code']!,
                                  child: Text(o['label']!),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => _languageCode = value);
                          provider.setLocaleByLanguageCode(value);
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  // Audio Guidance
                  _buildFieldLabel(AppLocalizations.of(context)!.audioGuidance),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox.shrink(),
                        Switch(
                          value: _audioGuidance,
                          onChanged: (value) =>
                              setState(() => _audioGuidance = value),
                          activeThumbColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Terms & Conditions
                  Row(
                    children: [
                      Checkbox(
                        value: _acceptTerms,
                        onChanged: (value) {
                          setState(() {
                            _acceptTerms = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.agreeTerms,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: (_isLoading || !_acceptTerms) ? null : _handleContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade400,
                        disabledBackgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Text(

                              AppLocalizations.of(context)!.continueText,

                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget _buildNumberDropdown({
    required int value,
    required List<int> items,
    required Function(int) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<int>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item.toString()),
          );
        }).toList(),
        onChanged: (val) => onChanged(val ?? value),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        hint: Text(AppLocalizations.of(context)!.selectOption),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        _lastPeriodDate = date;
      });
    }
  }

  Future<void> _handleContinue() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final currentUser = authService.currentUser;

      if (currentUser == null) {
        throw Exception('User not found');
      }

      await authService.updateUserProfile(
        userId: currentUser.id ?? '',
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.profileSetupComplete),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to home screen
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/home',
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(getAuthErrorMessage(context, e)),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
}


