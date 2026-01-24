import 'package:flutter/material.dart';
import '../../theme.dart';

class VerificationModal extends StatefulWidget {
  final String title;
  final void Function(String) onVerify;

  const VerificationModal({super.key, this.title = 'Verification Code', required this.onVerify});

  @override
  State<VerificationModal> createState() => _VerificationModalState();
}

class _VerificationModalState extends State<VerificationModal> {
  final List<String> _digits = ['', '', '', ''];
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(int idx, String v) {
    if (v.isEmpty) return;
    _digits[idx] = v.substring(v.length - 1);
    if (idx < _focusNodes.length - 1) {
      _focusNodes[idx + 1].requestFocus();
    } else {
      _focusNodes[idx].unfocus();
    }
    setState(() {});
  }

  String get _code => _digits.join();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person_outline, size: 48, color: AppColors.primary),
              const SizedBox(height: 12),
              Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Enter the 4-digit code we sent to your contact'),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (i) {
                  return SizedBox(
                    width: 48,
                    child: TextField(
                      focusNode: _focusNodes[i],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: const InputDecoration(counterText: ''),
                      onChanged: (v) => _onChanged(i, v),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                  onPressed: _code.trim().length == 4 ? () => widget.onVerify(_code) : null,
                  child: const Text('Verify'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
