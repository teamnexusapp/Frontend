import 'package:flutter/material.dart';

class CommunityTabScreen extends StatefulWidget {
  const CommunityTabScreen({Key? key}) : super(key: key);

  @override
  State<CommunityTabScreen> createState() => _CommunityTabScreenState();
}

class _CommunityTabScreenState extends State<CommunityTabScreen> {
  String _currentAffirmation = "Every challenge is an opportunity to grow stronger and wiser.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        backgroundColor: const Color(0xFF2E683D),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 20),
            decoration: const BoxDecoration(
              color: Color(0xFF2E683D),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Support hub',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Mental health support and daily affirmations',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 361,
                    height: 130,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA8D497).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFF2E683D),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.flash_on,
                              color: const Color(0xFF2E683D),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Daily affirmation',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2E683D),
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _currentAffirmation = "You are stronger than you think.";
                                });
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.refresh,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _currentAffirmation,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF2E683D),
                            fontFamily: 'Poppins',
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Cultural Guidance',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(
                      'Coping with family pressure and finding peace in community support. Explore recommended readings and groups.',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Explore Community Groups'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
