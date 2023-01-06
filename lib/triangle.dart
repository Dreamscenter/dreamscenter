import 'dart:math';

import 'package:flutter/material.dart';

class Triangle extends StatelessWidget {
  final Color color;
  final double? size;
  final int rotation;

  const Triangle({super.key, this.color = Colors.black, this.size, this.rotation = 0});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: rotation,
      child: SizedBox(
        width: size,
        height: getHeight(),
        child: CustomPaint(painter: TrianglePainter(color)),
      ),
    );
  }

  getHeight() {
    final size = this.size;
    if (size == null) return null;
    return size * sqrt(3) / 2;
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.color != color;
  }

  @override
  bool shouldRebuildSemantics(TrianglePainter oldDelegate) => false;
}
