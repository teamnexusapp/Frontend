import 'package:flutter/material.dart';

class SpecialistSearchScreen extends StatelessWidget {
  const SpecialistSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final specialists = const [
      {
        'name': 'Dr. Amara Obi',
        'role': 'Fertility Specialist',
        'location': 'Lekki, Lagos',
        'distance': '2.1 km away',
        'status': 'Available this week',
      },
      {
        'name': 'Dr. Yusuf Bello',
        'role': 'Gynecologist',
        'location': 'Abuja Central',
        'distance': '4.3 km away',
        'status': 'Accepting new patients',
      },
      {
        'name': 'Adaeze Nwosu',
        'role': 'Mental Health Counselor',
        'location': 'Ikeja, Lagos',
        'distance': '5.0 km away',
        'status': 'Next slot: Tomorrow',
      },
      {
        'name': 'Chinedu Okafor',
        'role': 'Nutritionist',
        'location': 'VI, Lagos',
        'distance': '6.8 km away',
        'status': 'Video consults available',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Specialist'),
        backgroundColor: const Color(0xFF2E683D),
      ),
      backgroundColor: const Color(0xFFF5F5F0),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Search specialists by name or specialty',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF2E683D)),
                  suffixIcon: const Icon(Icons.tune, color: Color(0xFF2E683D)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Search coming soon')),
                  );
                },
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: const [
                  _CategoryChip(label: 'Fertility'),
                  _CategoryChip(label: 'Gynecology'),
                  _CategoryChip(label: 'Mental Health'),
                  _CategoryChip(label: 'Nutrition'),
                  _CategoryChip(label: 'Endocrinology'),
                ],
              ),
              const SizedBox(height: 20),
              ...specialists.map((sp) => _SpecialistCard(data: sp)).toList(),
            ],
          ),
          _LockedOverlay(onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Upgrade to premium to unlock specialists')),
            );
          }),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  const _CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFA8D497).withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF2E683D).withOpacity(0.2)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF2E683D),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SpecialistCard extends StatelessWidget {
  final Map<String, String> data;
  const _SpecialistCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final name = data['name'] ?? '';
    final role = data['role'] ?? '';
    final location = data['location'] ?? '';
    final distance = data['distance'] ?? '';
    final status = data['status'] ?? '';

    String _initials(String input) {
      final parts = input.split(' ');
      if (parts.length == 1) return parts.first.isNotEmpty ? parts.first[0].toUpperCase() : '?';
      return (parts[0].isNotEmpty ? parts[0][0] : '') + (parts[1].isNotEmpty ? parts[1][0] : '');
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2E683D).withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFFA8D497),
            child: Text(
              _initials(name),
              style: const TextStyle(
                color: Color(0xFF2E683D),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  role,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2E683D),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.place, size: 16, color: Color(0xFF2E683D)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.place_outlined, size: 16, color: Color(0xFF2E683D)),
                    const SizedBox(width: 4),
                    Text(
                      distance,
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  status,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2E683D),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Viewing $name coming soon')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E683D),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              elevation: 0,
              minimumSize: const Size(10, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'View',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
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
                  Icon(Icons.lock, size: 56, color: Colors.white),
                  SizedBox(height: 12),
                  Text(
                    'Premium feature',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Upgrade to search and book specialists',
                    style: TextStyle(
                      color: Colors.white70,
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
