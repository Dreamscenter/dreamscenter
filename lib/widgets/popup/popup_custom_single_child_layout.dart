import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PopupCustomSingleChildLayout extends CustomSingleChildLayout {
  const PopupCustomSingleChildLayout({super.key, required super.delegate, super.child});

  @override
  RenderCustomSingleChildLayoutBox createRenderObject(BuildContext context) =>
      RenderPopupCustomSingleChildLayout(delegate: delegate);
}

class RenderPopupCustomSingleChildLayout extends RenderCustomSingleChildLayoutBox {
  RenderPopupCustomSingleChildLayout({required super.delegate});

  @override
  void performLayout() {
    invokeLayoutCallback((_) {
      super.performLayout();
    });
  }
}
