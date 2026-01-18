import 'package:flutter/material.dart';
import 'group_details_screen.dart';

class GroupChatScreen extends StatefulWidget {
  final String groupName;
  final String groupDescription;
  final List<String> members;
  final int memberCount;

  const GroupChatScreen({
    super.key,
    required this.groupName,
    required this.groupDescription,
    required this.members,
    required this.memberCount,
  });

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      'sender': 'Sarah',
      'message': 'Thank you all for the support!',
      'time': '2:30 PM',
    },
    {
      'sender': 'Amara',
      'message': 'We\'re all here for each other',
      'time': '2:45 PM',
    },
    {
      'sender': 'You',
      'message': 'This group means so much to me',
      'time': '3:00 PM',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'sender': 'You',
          'message': _messageController.text,
          'time': 'Now',
        });
        _messageController.clear();
      });
    }
  }

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
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => GroupDetailsScreen(
                  groupName: widget.groupName,
                  groupDescription: widget.groupDescription,
                  members: widget.members,
                  memberCount: widget.memberCount,
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.groupName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                '${widget.memberCount} members',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isYourMessage = message['sender'] == 'You';

                return Align(
                  alignment: isYourMessage ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isYourMessage ? const Color(0xFF2E683D) : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: isYourMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        if (!isYourMessage)
                          Text(
                            message['sender']!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        if (!isYourMessage) const SizedBox(height: 4),
                        Text(
                          message['message']!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: isYourMessage ? Colors.white : Colors.black,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message['time']!,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: isYourMessage ? Colors.white70 : Colors.grey.shade600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Message input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontFamily: 'Poppins',
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(
                          color: Color(0xFF2E683D),
                          width: 2,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E683D),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
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
