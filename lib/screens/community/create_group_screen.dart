import 'package:flutter/material.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _groupNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<String> _selectedMembers = [];

  @override
  void dispose() {
    _groupNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _addMembers() {
    // TODO: Implement member selection dialog
    debugPrint('Add members tapped');
  }

  void _createGroup() {
    // TODO: Implement group creation logic
    debugPrint('Create group with name: ${_groupNameController.text}');
    debugPrint('Description: ${_descriptionController.text}');
    debugPrint('Members: $_selectedMembers');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E683D),
        title: const Text(
          'Create Group',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Group name section
            const Text(
              'Group name',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _groupNameController,
              decoration: InputDecoration(
                hintText: 'Enter group name',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Poppins',
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
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
            const SizedBox(height: 24),
            // Description section
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter group description',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Poppins',
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
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
            const SizedBox(height: 24),
            // Members section
            const Text(
              'Members',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            // Add members button
            GestureDetector(
              onTap: _addMembers,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.add,
                      color: Color(0xFF2E683D),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _selectedMembers.isEmpty ? 'Add members' : '${_selectedMembers.length} member${_selectedMembers.length > 1 ? 's' : ''} added',
                      style: const TextStyle(
                        color: Color(0xFF2E683D),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Create Group button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _createGroup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E683D),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Create Group',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
