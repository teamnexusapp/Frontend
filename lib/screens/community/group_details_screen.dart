import 'package:flutter/material.dart';

class GroupDetailsScreen extends StatelessWidget {
  final String groupName;
  final String groupDescription;
  final List<String> members;
  final int memberCount;

  const GroupDetailsScreen({
    super.key,
    required this.groupName,
    required this.groupDescription,
    required this.members,
    required this.memberCount,
  });

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
        title: const Text(
          'Group Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Group name section
            Text(
              groupName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFA8D497),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$memberCount members',
                style: const TextStyle(
                  color: Color(0xFF2E683D),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Description section
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                groupDescription,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade700,
                  fontFamily: 'Poppins',
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Members section
            const Text(
              'Members',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: members.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFA8D497),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            members[index][0].toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xFF2E683D),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        members[index],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
