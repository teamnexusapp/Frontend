import 'package:flutter/material.dart';

class SpecialistChatScreen extends StatelessWidget {
  const SpecialistChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mockMessages = const [
      {'sender': 'Specialist', 'text': 'Hi! How can I assist you today?'},
      {'sender': 'You', 'text': 'I need guidance on my current plan.'},
      {'sender': 'Specialist', 'text': 'Sure, let me review your notes and suggest next steps.'},
    ];

    final TextEditingController _messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with Specialist'),
        backgroundColor: const Color(0xFF2E683D),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: mockMessages.length,
                  itemBuilder: (context, index) {
                    final msg = mockMessages[index];
                    final isUser = msg['sender'] == 'You';
                    return Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isUser ? const Color(0xFFA8D497) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          msg['text'] ?? '',
                          style: TextStyle(
                            color: isUser ? const Color(0xFF2E683D) : Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                            hintText: 'Type a message...',
                            border: InputBorder.none,
                          ),
                          minLines: 1,
                          maxLines: 4,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sending messages coming soon')),
                        );
                        _messageController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E683D),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                      child: const Icon(Icons.send, size: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _LockedOverlay(onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: Row(
                    children: const [
                      Icon(Icons.lock, color: Color(0xFF2E683D), size: 28),
                      SizedBox(width: 12),
                      Text(
                        'Premium Feature',
                        style: TextStyle(
                          color: Color(0xFF2E683D),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  content: const Text(
                    'Upgrade to premium to chat with specialists and get personalized advice.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Maybe Later',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Navigate to premium upgrade screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E683D),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Upgrade Now'),
                    ),
                  ],
                );
              },
            );
          }),
        ],
      ),
      backgroundColor: const Color(0xFFF5F5F0),
    );
  }
}

class _LockedOverlay extends StatelessWidget {
  final VoidCallback onTap;
  const _LockedOverlay({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.45),
                  Colors.black.withOpacity(0.25),
                  Colors.black.withOpacity(0.05),
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.lock, size: 56, color: Color(0xFF2E683D)),
                  SizedBox(height: 12),
                  Text(
                    'Premium feature',
                    style: TextStyle(
                      color: Color(0xFF2E683D),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Upgrade to chat with specialists',
                    style: TextStyle(
                      color: Color(0xFF2E683D),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
