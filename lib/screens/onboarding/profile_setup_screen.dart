import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Fertipath/flutter_gen/gen_l10n/app_localizations.dart';
import '../../services/auth_service.dart';


import '../../services/auth_error_helper.dart';
import '../../services/localization_provider.dart';
import '../../services/api_service.dart';


class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  int _age = 27;
  int _cycleLength = 28;
  int _periodLength = 5;
  DateTime? _lastPeriodDate;
  // Removed first and last name controllers
  String? _ttcHistory;
  String? _faithPreference;
  // Removed language code
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

  // Removed language options

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
                    Color(0xFF2D5A3A), // dark green
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

                  // Removed first and last name fields

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

                  // Period Length
                  _buildFieldLabel('Period Length (days)'),
                  _buildNumberDropdown(
                    value: _periodLength,
                    items: List.generate(15, (i) => i + 1),
                    onChanged: (value) => setState(() => _periodLength = value),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'How many days do you usually bleed during your period?',
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

                  // Removed language field

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
                          activeColor: Color(0xFF2D5A3A), // dark green
                          activeTrackColor: Color(0xFFD4E9D7), // light green track
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
                        activeColor: Color(0xFF2D5A3A), // dark green
                        checkColor: Colors.white,
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
                        backgroundColor: Color(0xFF2D5A3A), // dark green
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
      // Prepare the request body according to the schema
      final Map<String, dynamic> body = {
        "age": _age,
        "cycle_length": _cycleLength,
        "period_length": _periodLength,
        "last_period_date": _lastPeriodDate != null
            ? _lastPeriodDate!.toIso8601String().split('T')[0]
            : null,
        "ttc_history": _ttcHistory ?? '',
        "faith_preference": _faithPreference ?? '',
        "audio_preference": _audioGuidance,
      };

      // Send PUT request to user/profile
      final apiService = ApiService();
      final response = await apiService.updateProfile(
        age: _age,
        cycleLength: _cycleLength,
        periodLength: _periodLength,
        lastPeriodDate: _lastPeriodDate != null
            ? _lastPeriodDate!.toIso8601String().split('T')[0]
            : null,
        ttcHistory: _ttcHistory ?? '',
        faithPreference: _faithPreference ?? '',
        audioPreference: _audioGuidance,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.profileSetupComplete),
            backgroundColor: Colors.green,
          ),
        );
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
    // Removed firstNameController and lastNameController dispose
    super.dispose();
  }
}


