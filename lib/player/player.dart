import 'package:dreamscenter/device_info.dart';
import 'package:dreamscenter/player/fullscreen/fullscreen.dart';
import 'package:dreamscenter/player/overlay/overlay_hider.dart';
import 'package:dreamscenter/player/overlay/player_overlay.dart';
import 'package:dreamscenter/player/player_view_model.dart';
import 'package:dreamscenter/player/video_player/video_player.dart';
import 'package:dreamscenter/widgets/enhanced_animated_opacity.dart';
import 'package:dreamscenter/widgets/enhanced_mouse_region/enhanced_mouse_region.dart';
import 'package:dreamscenter/widgets/interaction_detector.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() {
    final playerViewModel = PlayerViewModel();
    final overlayHider = OverlayHider(playerViewModel);
    return _PlayerState(playerViewModel, overlayHider);
  }
}

class _PlayerState extends State<Player> {
  PlayerViewModel viewModel;
  OverlayHider overlayHider;

  _PlayerState(this.viewModel, this.overlayHider);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: viewModel),
      ],
      child: Consumer<PlayerViewModel>(builder: (_, __, ___) {
        return InteractionDetector(
          onHover: (_) => overlayHider.onMouseMovement(),
          onDrag: (_) => overlayHider.onMouseMovement(),
          child: EnhancedMouseRegion(
            cursor: viewModel.showOverlay ? SystemMouseCursors.basic : SystemMouseCursors.none,
            child: Stack(children: [
              InteractionDetector(
                onTapDown: (_) => onPlayerTapDown(),
                onTap: onPlayerTap,
                onDoubleTap: () {
                  if (isInDesktopMode()) {
                    switchFullscreen();
                  }
                },
                child: VideoPlayer(viewModel: viewModel),
              ),
              EnhancedAnimatedOpacity(
                opacity: viewModel.showOverlay ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: const PlayerOverlay(),
              ),
            ]),
          ),
        );
      }),
    );
  }

  bool tapConsumed = false;
  
  void onPlayerTapDown() {
    if (viewModel.openedPopup != null) {
      viewModel.openedPopup = null;
      tapConsumed = true;
      return;
    }

    overlayHider.onPlayerTapDown();
  }
  
  void onPlayerTap() {
    if (tapConsumed) {
      tapConsumed = false;
      return;
    }

    if (isInDesktopMode()) {
      viewModel.switchPause();
    }
  }

  @override
  void initState() {
    super.initState();
    viewModel.init();
    overlayHider.init();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
    overlayHider.dispose();
  }
}
