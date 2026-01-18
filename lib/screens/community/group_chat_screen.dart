import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
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
  final List<Map<String, String>> _messages = [];
  late SharedPreferences _prefs;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeMessages();
  }

  Future<void> _initializeMessages() async {
    _prefs = await SharedPreferences.getInstance();
    _loadMessages();
  }

  void _loadMessages() {
    final String? messagesJson = _prefs.getString('${widget.groupName}_messages');
    setState(() {
      if (messagesJson != null) {
        final List<dynamic> decodedMessages = jsonDecode(messagesJson);
        _messages.clear();
        _messages.addAll(
          decodedMessages.map((msg) => {
            'sender': msg['sender'] as String,
            'message': msg['message'] as String,
            'time': msg['time'] as String,
          }).toList(),
        );
      } else {
        // Initialize with sample messages on first load
        _messages.addAll([
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
        ]);
        _saveMessages();
      }
      _isLoading = false;
    });
  }

  Future<void> _saveMessages() async {
    final messagesJson = jsonEncode(_messages);
    await _prefs.setString('${widget.groupName}_messages', messagesJson);
  }

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
      _saveMessages();
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
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isYourMessage = message['sender'] == 'You';

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: isYourMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Avatar for other users
                            if (!isYourMessage)
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFA8D497),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    message['sender']![0].toUpperCase(),
                                    style: const TextStyle(
                                      color: Color(0xFF2E683D),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                            if (!isYourMessage) const SizedBox(width: 8),
                            // Message bubble
                            Flexible(
                              child: Container(
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
                            ),
                            // Avatar for your messages
                            if (isYourMessage) const SizedBox(width: 8),
                            if (isYourMessage)
                              Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2E683D),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Text(
                                    'Y',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                          ],
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
