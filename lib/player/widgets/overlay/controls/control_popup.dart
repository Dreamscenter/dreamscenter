import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/triangle.dart';
import 'package:flutter/widgets.dart';

class ControlPopup extends StatelessWidget {
  const ControlPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: DefaultColors.background,
          ),
        ),
        const Triangle()
      ],
    );
  }
}
