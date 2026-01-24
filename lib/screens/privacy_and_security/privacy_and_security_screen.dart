import 'package:flutter/material.dart';

class PrivacyAndSecurityScreen extends StatelessWidget {
  static const routeName = '/privacy-and-security';
  const PrivacyAndSecurityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E683D),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Security Shield Icon
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF2E683D),
                  width: 3,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.security_outlined,
                  size: 120,
                  color: Color(0xFF2E683D),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Privacy and Security Title with Underline
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Privacy and Security',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2E683D),
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 2,
                  width: 180,
                  color: const Color(0xFF2E683D),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Settings Cards
            _buildSettingsCard(
              context,
              title: 'Data Privacy and Policy',
              icon: Icons.privacy_tip_outlined,
              items: [
                'Your fertility data is encrypted end-to-end',
                'Medical records are stored securely',
                'Cycle tracking data never shared without consent',
                'Third-party access requires your approval',
              ],
            ),
            const SizedBox(height: 16),
            _buildSettingsCard(
              context,
              title: 'Manage Data and Permissions',
              icon: Icons.lock_outline,
              items: [
                'Control location permissions',
                'Manage notification preferences',
                'Choose data sharing with healthcare providers',
                'Set data retention policies',
              ],
            ),
            const SizedBox(height: 16),
            _buildSettingsCard(
              context,
              title: 'Explore My Data',
              icon: Icons.assessment_outlined,
              items: [
                'Download all your personal data',
                'View cycle history and predictions',
                'Access community group activity',
                'Review account activity logs',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<String> items,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF2E683D),
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2E683D),
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Color(0xFFA8D497),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
