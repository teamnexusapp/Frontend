import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nexus_fertility_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../services/localization_provider.dart' as loc_provider;
import 'welcome_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? _selectedCode;

  List<Map<String, String>> _languages(BuildContext context) => [
        {'code': 'en', 'name': 'English'},
        {'code': 'ig', 'name': 'Igbo'},
        {'code': 'yo', 'name': 'Yoruba'},
        {'code': 'ha', 'name': 'Hausa'},
      ];

  void _handleSelect(String code) {
    setState(() => _selectedCode = code);
  }

  Future<void> _handleNext(BuildContext context) async {
    if (_selectedCode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.selectOption)),
      );
      return;
    }
    context.read<loc_provider.LocalizationProvider>().setLocaleByLanguageCode(_selectedCode!);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final langs = _languages(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF224D2D),
              Color(0xFF4FB369),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Select preferred Language',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    ...langs.map((lang) {
                      final isSelected = _selectedCode == lang['code'];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: SizedBox(
                          width: 250,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () => _handleSelect(lang['code']!),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF224D2D),
                              side: BorderSide(
                                color: isSelected
                                    ? const Color(0xFF224D2D)
                                    : const Color(0x33224D2D),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: isSelected ? 6 : 2,
                            ),
                            child: Text(
                              lang['name']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 32),
                    Align(
                      alignment: const Alignment(0.25, 0),
                      child: SizedBox(
                        width: 99,
                        height: 47,
                        child: ElevatedButton(
                          onPressed: () => _handleNext(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFA8D497),
                            foregroundColor: const Color(0xFF224D2D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Color(0xFF224D2D),
                            ),
                          ),
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
    );
  }
}
