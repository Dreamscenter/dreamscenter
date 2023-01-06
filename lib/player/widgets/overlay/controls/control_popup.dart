import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/triangle.dart';
import 'package:flutter/material.dart';

class ControlPopup extends StatelessWidget {
  final Widget child;
  final double x;
  final double y;

  const ControlPopup({super.key, required this.child, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: x, top: y),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(9)),
              color: DefaultColors.background,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: child,
            ),
          ),
          const Triangle(
            color: Colors.red,
            size: 20,
            rotation: 2,
          ),
        ],
      ),
    );
  }
}
