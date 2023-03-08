import 'package:dreamscenter/widgets/interaction_detector.dart';
import 'package:flutter/material.dart';

class Control extends StatelessWidget {
  final Widget icon;
  final void Function() onTap;
  final double extraHitboxSize;
  final bool dropShadow;

  const Control({
    super.key,
    required this.icon,
    required this.onTap,
    required this.extraHitboxSize,
    this.dropShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final fitted = FittedBox(
      fit: BoxFit.contain,
      child: icon,
    );

    final withShadow = Container(
      decoration: BoxDecoration(
        boxShadow: [
          if (dropShadow)
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: fitted,
    );

    final clickable = InteractionDetector(
      onTap: onTap,
      showClickCursor: true,
      extraHitboxSize: extraHitboxSize,
      child: withShadow,
    );

    return AspectRatio(
      aspectRatio: 1,
      child: clickable,
    );
  }
}
