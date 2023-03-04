import 'dart:async';

import 'package:dreamscenter/player/fullscreen/fullscreen.dart';
import 'package:dreamscenter/player/overlay/player_overlay.dart';
import 'package:dreamscenter/player/player_viewmodel.dart';
import 'package:dreamscenter/player/video_player/video_player.dart';
import 'package:dreamscenter/player/video_player/video_player_viewmodel.dart';
import 'package:dreamscenter/widgets/enhanced_animated_opacity.dart';
import 'package:dreamscenter/widgets/enhanced_mouse_region/enhanced_mouse_region.dart';
import 'package:dreamscenter/widgets/interaction_detector.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  Timer? hideOverlayTimer;
  bool showOverlay = true;
  late PlayerViewModel playerViewModel;
  late VideoPlayerViewModel videoPlayerViewModel = VideoPlayerViewModel();
  late StreamSubscription<void> pauseOrPlayEventsSubscription;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayerViewModel()),
        ChangeNotifierProvider.value(value: videoPlayerViewModel),
      ],
      child: Consumer<PlayerViewModel>(builder: (context, model, __) {
        playerViewModel = model;
        return InteractionDetector(
          onHover: updateOverlay,
          child: EnhancedMouseRegion(
            cursor: showOverlay ? SystemMouseCursors.basic : SystemMouseCursors.none,
            child: Stack(children: [
              InteractionDetector(
                onTapDown: () {
                  if (playerViewModel.openedPopup != null) {
                    playerViewModel.openedPopup = null;
                    return;
                  }
                  videoPlayerViewModel.switchPause();
                },
                onDoubleTap: switchFullscreen,
                child: VideoPlayer(
                  source: model.source,
                  viewModel: videoPlayerViewModel,
                ),
              ),
              EnhancedAnimatedOpacity(
                opacity: showOverlay ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: const PlayerOverlay(),
              ),
            ]),
          ),
        );
      }),
    );
  }

  void updateOverlay() {
    if (!showOverlay) {
      setState(() {
        showOverlay = true;
      });
    }

    hideOverlayTimer?.cancel();

    if (videoPlayerViewModel.isPaused || playerViewModel.openedPopup != null) {
      return;
    }

    hideOverlayTimer = Timer(const Duration(seconds: 1), () {
      if (showOverlay == false) return;
      setState(() {
        showOverlay = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    pauseOrPlayEventsSubscription = videoPlayerViewModel.pauseOrPlayEvents.listen((event) {
      updateOverlay();
    });
  }

  @override
  void dispose() {
    super.dispose();
    hideOverlayTimer?.cancel();
    pauseOrPlayEventsSubscription.cancel();
  }
}
