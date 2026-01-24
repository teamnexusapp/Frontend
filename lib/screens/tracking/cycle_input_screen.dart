import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CycleInputScreen extends StatefulWidget {
  const CycleInputScreen({super.key});

  @override
  State<CycleInputScreen> createState() => _CycleInputScreenState();
}

class _CycleInputScreenState extends State<CycleInputScreen> {
  DateTime? _startDate;
  final _cycleController = TextEditingController(text: '28');
  String _goal = 'Conceive';
  bool _saving = false;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) setState(() => _startDate = picked);
  }

  Future<void> _save() async {
    if (_startDate == null) return;
    setState(() => _saving = true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cycle_start_date', _startDate!.toIso8601String());
    await prefs.setInt('cycle_length', int.tryParse(_cycleController.text) ?? 28);
    await prefs.setString('primary_goal', _goal);
    setState(() => _saving = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved')));
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _cycleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cycle Input')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Start Date', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(_startDate == null ? 'Choose date' : _startDate!.toLocal().toString().split(' ')[0]),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Cycle Length (days)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _cycleController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '28',
              ),
            ),
            const SizedBox(height: 16),
            const Text('Primary Goal', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: _goal,
              items: const [
                DropdownMenuItem(value: 'Conceive', child: Text('Conceive')),
                DropdownMenuItem(value: 'Avoid Pregnancy', child: Text('Avoid Pregnancy')),
                DropdownMenuItem(value: 'Track Only', child: Text('Track Only')),
              ],
              onChanged: (v) => setState(() => _goal = v ?? 'Conceive'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                child: _saving ? const CircularProgressIndicator() : const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
