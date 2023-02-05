import 'package:dreamscenter/default_colors.dart';
import 'package:flutter/material.dart';

class PopupBox extends StatelessWidget {
  final Widget child;

  const PopupBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(9)),
        color: DefaultColors.background,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: child,
      ),
    );
  }
}
