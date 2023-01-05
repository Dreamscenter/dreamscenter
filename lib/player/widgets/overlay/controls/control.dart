import 'package:flutter/material.dart';

class Control extends StatelessWidget {
  final Widget icon;
  final Function onPressed;

  const Control({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (_) => onPressed(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: icon,
        ),
      ),
    );
  }
}
