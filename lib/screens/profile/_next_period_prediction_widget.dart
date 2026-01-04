import 'package:flutter/material.dart';
import 'dart:math' as math;

class NextPeriodPredictionWidget extends StatelessWidget {
  final DateTime nextPeriodDate;
  final String label;

  const NextPeriodPredictionWidget({Key? key, required this.nextPeriodDate, this.label = 'Next Period'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.red,
          width: 3,
          style: BorderStyle.solid,
        ),
      ),
      child: CustomPaint(
        painter: _DashedCirclePainter(),
        child: SizedBox(
          width: 90,
          height: 90,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _formatDate(nextPeriodDate),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }
}

class _DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    const int dashCount = 40;
    const double gap = 2;
    final double radius = (size.width / 2) - 1.5;
    final double dashLength = 2 * 3.141592653589793 * radius / dashCount - gap;

    for (int i = 0; i < dashCount; i++) {
      final double startAngle = (2 * 3.141592653589793 * i) / dashCount;
      final double endAngle = startAngle + (dashLength / radius);
      final Offset start = Offset(
        size.width / 2 + radius * Math.cos(startAngle),
        size.height / 2 + radius * Math.sin(startAngle),
      );
      final Offset end = Offset(
        size.width / 2 + radius * Math.cos(endAngle),
        size.height / 2 + radius * Math.sin(endAngle),
      );
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Math helpers
class Math {
  static double cos(double radians) =>
    double.parse((math.cos(radians)).toStringAsFixed(10));
  static double sin(double radians) =>
    double.parse((math.sin(radians)).toStringAsFixed(10));
}
