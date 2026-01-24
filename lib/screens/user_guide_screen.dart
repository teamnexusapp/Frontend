import 'package:flutter/material.dart';

class UserGuideScreen extends StatelessWidget {
  const UserGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E683D),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'How to Use Fertipath',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Fertipath!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
                color: Color(0xFF2E683D),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Follow these steps to get the best results from our fertility tracking features.',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            
            _buildGuideSection(
              number: '1',
              title: 'Complete Your Profile',
              description: 'Go to Profile → Settings to enter your cycle length, period length, and faith preference. Accurate data helps us provide better predictions.',
              icon: Icons.person_outline,
            ),
            
            _buildGuideSection(
              number: '2',
              title: 'Track Your Period',
              description: 'Tap the Calendar tab and select the days you\'re on your period. This helps us predict your next cycle, fertile window, and ovulation day.',
              icon: Icons.calendar_today,
            ),
            
            _buildGuideSection(
              number: '3',
              title: 'Log Daily Symptoms',
              description: 'Use the "Log Symptoms" button to record mood, cervical mucus, basal body temperature, and other symptoms. This improves prediction accuracy.',
              icon: Icons.edit_note,
            ),
            
            _buildGuideSection(
              number: '4',
              title: 'Check Your Insights',
              description: 'Your home screen shows daily fertility insights based on your data. Review fertile days, ovulation predictions, and cycle summaries.',
              icon: Icons.insights,
            ),
            
            _buildGuideSection(
              number: '5',
              title: 'Listen to Audio Content',
              description: 'Explore the Educational Hub for articles and audio lessons. Use the speed controls (0.75x - 2x) to adjust playback to your preference.',
              icon: Icons.headphones,
            ),
            
            _buildGuideSection(
              number: '6',
              title: 'Get Mental Health Support',
              description: 'Visit the Support tab for faith-based affirmations and resources. Choose your faith preference in settings for personalized content.',
              icon: Icons.support_agent,
            ),
            
            _buildGuideSection(
              number: '7',
              title: 'Review Predictions',
              description: 'Your calendar marks predicted next period days with red outlined circles. Past periods appear as filled red circles.',
              icon: Icons.timeline,
            ),
            
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFA8D497).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF2E683D),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: Color(0xFF2E683D),
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Pro Tips',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          color: Color(0xFF2E683D),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    '• Log symptoms daily for 2-3 cycles to get the most accurate predictions\n\n'
                    '• Update your period dates as soon as your cycle starts\n\n'
                    '• Check your fertile window to plan or avoid conception\n\n'
                    '• Use audio content at 1.25x or 1.5x speed to learn faster\n\n'
                    '• Enable notifications to get reminders for symptom logging',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(
                        Icons.help_outline,
                        color: Color(0xFF2E683D),
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Need Help?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          color: Color(0xFF2E683D),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'If you have questions or encounter issues, visit the Support tab or check the Educational Hub for detailed guides on fertility tracking.',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideSection({
    required String number,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF2E683D),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: const Color(0xFF2E683D),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Color(0xFF2E683D),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
