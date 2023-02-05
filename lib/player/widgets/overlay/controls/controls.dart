import 'package:dreamscenter/player/widgets/overlay/controls/source/source_control.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/syncplay/syncplay_control.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/volume/volume_control.dart';
import 'package:flutter/material.dart';

class Controls extends StatefulWidget {
  final Widget progressBar;

  const Controls({super.key, required this.progressBar});

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  final GlobalKey popupBoundary = GlobalKey();
  final GlobalKey volume = GlobalKey();
  final GlobalKey source = GlobalKey();
  final GlobalKey syncplay = GlobalKey();

  @override
  Widget build(BuildContext context) {
    const buttonSpacing = 21.0;
    return LayoutBuilder(
        key: popupBoundary,
        builder: (context, constraints) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: constraints.maxHeight * .05 > 20 ? constraints.maxHeight * .05 : 20),
              width: constraints.maxWidth * .05 > 40 ? constraints.maxWidth * .95 : constraints.maxWidth - 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3) + const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      height: 24,
                      child: Row(
                        children: [
                          VolumeControl(
                              key: volume, popupBoundary: popupBoundary, showPopup: false, onOpenPopup: () {}),
                          const SizedBox(width: buttonSpacing),
                          SourceControl(
                              key: source, popupBoundary: popupBoundary, showPopup: false, onOpenPopup: () {}),
                          const SizedBox(width: buttonSpacing),
                          SyncplayControl(
                              key: syncplay, popupBoundary: popupBoundary, showPopup: false, onOpenPopup: () {}),
                        ],
                      ),
                    ),
                  ),
                  widget.progressBar,
                ],
              ),
            ),
          );
        });
  }
}
