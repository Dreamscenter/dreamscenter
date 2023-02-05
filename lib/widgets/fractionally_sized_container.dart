import 'package:flutter/widgets.dart';

class FractionallySizedContainer extends StatelessWidget {
  final double? widthFactor;
  final double? heightFactor;
  final EdgeInsets? marginFactor;
  final double minWidth;
  final double minHeight;
  final EdgeInsets minMargin;
  final Widget? child;

  const FractionallySizedContainer({
    super.key,
    this.widthFactor,
    this.heightFactor,
    this.marginFactor,
    this.minWidth = 0.0,
    this.minHeight = 0.0,
    this.minMargin = const EdgeInsets.all(0),
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: getWidth(constraints),
        height: getHeight(constraints),
        margin: getMargin(constraints),
        child: child,
      );
    });
  }

  getWidth(BoxConstraints constraints) {
    if (widthFactor == null) {
      return null;
    }

    final width = widthFactor! * constraints.maxWidth;
    return width.clamp(minWidth, double.infinity);
  }

  getHeight(BoxConstraints constraints) {
    if (heightFactor == null) {
      return null;
    }

    final height = heightFactor! * constraints.maxHeight;
    return height.clamp(minHeight, double.infinity);
  }

  getMargin(BoxConstraints constraints) {
    if (marginFactor == null) {
      return null;
    }

    final margin = EdgeInsets.only(
      left: marginFactor!.left * constraints.maxWidth,
      top: marginFactor!.top * constraints.maxHeight,
      right: marginFactor!.right * constraints.maxWidth,
      bottom: marginFactor!.bottom * constraints.maxHeight,
    );

    return EdgeInsets.only(
      left: margin.left.clamp(minMargin.left, double.infinity),
      top: margin.top.clamp(minMargin.top, double.infinity),
      right: margin.right.clamp(minMargin.right, double.infinity),
      bottom: margin.bottom.clamp(minMargin.bottom, double.infinity),
    );
  }
}
