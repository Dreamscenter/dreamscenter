import 'package:dreamscenter/player/fullscreen/fullscreen.dart';
import 'package:dreamscenter/player/overlay/player_overlay.dart';
import 'package:dreamscenter/player/overlay_hider.dart';
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
  PlayerViewModel playerViewModel = PlayerViewModel();
  VideoPlayerViewModel videoPlayerViewModel = VideoPlayerViewModel();
  late OverlayHider overlayHider;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: playerViewModel),
        ChangeNotifierProvider.value(value: videoPlayerViewModel),
      ],
      child: Consumer<PlayerViewModel>(builder: (_, __, ___) {
        return AnimatedBuilder(
            animation: overlayHider,
            builder: (_, __) {
              return InteractionDetector(
                onHover: overlayHider.onMouseMovement,
                child: EnhancedMouseRegion(
                  cursor: overlayHider.showOverlay ? SystemMouseCursors.basic : SystemMouseCursors.none,
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
                        source: playerViewModel.source,
                        viewModel: videoPlayerViewModel,
                      ),
                    ),
                    EnhancedAnimatedOpacity(
                      opacity: overlayHider.showOverlay ? 1 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: const PlayerOverlay(),
                    ),
                  ]),
                ),
              );
            });
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    overlayHider = OverlayHider(playerViewModel, videoPlayerViewModel);
    playerViewModel.init();
    overlayHider.init();
  }

  @override
  void dispose() {
    super.dispose();
    playerViewModel.dispose();
    videoPlayerViewModel.dispose();
    overlayHider.dispose();
  }
}
