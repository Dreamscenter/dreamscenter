import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/triangle.dart';
import 'package:flutter/material.dart';

class ControlPopup extends StatelessWidget {
  final Widget content;
  final Widget child;

  const ControlPopup({super.key, required this.content, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      child,
      Transform.translate(
        offset: const Offset(0, -35),
        child: OverflowBox(
            maxWidth: double.infinity,
            maxHeight: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                    color: DefaultColors.background,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: content,
                  ),
                ),
                const Triangle(
                  color: DefaultColors.background,
                  size: 20,
                  rotation: 2,
                ),
              ],
            )),
      ),
    ]);
  }
}
