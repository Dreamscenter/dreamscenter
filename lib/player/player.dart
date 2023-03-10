import 'package:dreamscenter/device_info.dart';
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
  late PlayerViewModel playerViewModel;
  VideoPlayerViewModel videoPlayerViewModel = VideoPlayerViewModel();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: playerViewModel),
        ChangeNotifierProvider.value(value: videoPlayerViewModel),
      ],
      child: Consumer<PlayerViewModel>(builder: (_, __, ___) {
        return InteractionDetector(
          onHover: (_) => playerViewModel.onMouseMovement(),
          onDrag: (_) => playerViewModel.onMouseMovement(),
          child: EnhancedMouseRegion(
            cursor: playerViewModel.showOverlay ? SystemMouseCursors.basic : SystemMouseCursors.none,
            child: Stack(children: [
              InteractionDetector(
                onTap: playerViewModel.onPlayerTap,
                onTapDown: (_) => playerViewModel.onPlayerTapDown(),
                onDoubleTap: () {
                  if (isInDesktopMode()) {
                    switchFullscreen();
                  }
                },
                child: VideoPlayer(
                  source: playerViewModel.source,
                  viewModel: videoPlayerViewModel,
                ),
              ),
              EnhancedAnimatedOpacity(
                opacity: playerViewModel.showOverlay ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: const PlayerOverlay(),
              ),
            ]),
          ),
        );
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    playerViewModel = PlayerViewModel(videoPlayerViewModel);
    playerViewModel.init();
  }

  @override
  void dispose() {
    super.dispose();
    playerViewModel.dispose();
    videoPlayerViewModel.dispose();
  }
}
