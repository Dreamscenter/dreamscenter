import 'dart:async';

import 'package:dreamscenter/player/player_model.dart';
import 'package:dreamscenter/player/syncplay/syncplay_model.dart';
import 'package:dreamscenter/player/video_playback.dart';
import 'package:dreamscenter/player/widgets/overlay/player_overlay.dart';
import 'package:dreamscenter/player/widgets/video_player/video_player.dart'
    if (dart.library.io) 'package:dreamscenter/player/widgets/video_player/video_player_io.dart'
    if (dart.library.html) 'package:dreamscenter/player/widgets/video_player/video_player_web.dart';
import 'package:dreamscenter/widgets/enhanced_animated_opacity.dart';
import 'package:dreamscenter/widgets/enhanced_mouse_region/enhanced_mouse_region.dart';
import 'package:dreamscenter/widgets/interaction_detector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  Timer? hideOverlayTimer;
  bool showOverlay = false;
  late PlayerModel model;
  VideoPlayback? playback;
  bool wasPaused = false;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayerModel()),
        ChangeNotifierProvider(create: (_) => SyncplayModel()),
        ChangeNotifierProvider.value(value: playback),
      ],
      child: Consumer<PlayerModel>(builder: (_, model, __) {
        this.model = model;
        return InteractionDetector(
          onHover: updateOverlay,
          child: EnhancedMouseRegion(
            cursor: showOverlay ? SystemMouseCursors.basic : SystemMouseCursors.none,
            child: Stack(children: [
              InteractionDetector(
                onTapDown: () {
                  if (model.openedPopup != null) {
                    model.openedPopup = null;
                    return;
                  }
                  playback?.switchPause();
                },
                onDoubleTap: switchFullscreen,
                child: VideoPlayer(
                  source: model.source,
                  onPlaybackChange: onPlaybackChange,
                  onVolumeChanged: (newValue) => model.volume = newValue,
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

  updateOverlay() {
    if (!showOverlay) {
      setState(() {
        showOverlay = true;
      });
    }

    hideOverlayTimer?.cancel();

    if (playback == null || playback!.isPaused || model.openedPopup != null) {
      return;
    }

    hideOverlayTimer = Timer(const Duration(seconds: 1), () {
      if (showOverlay == false) return;
      setState(() {
        showOverlay = false;
      });
    });
  }

  switchFullscreen() async {
    if (kIsWeb) return;
    final isFullscreen = await WindowManager.instance.isFullScreen();
    await WindowManager.instance.setFullScreen(!isFullscreen);

    if (isFullscreen) {
      final size = await windowManager.getSize();
      await windowManager.setSize(Size(size.width + 1, size.height + 1));
    }
  }

  playbackListener() {
    final playback = this.playback!;
    if (wasPaused != playback.isPaused) {
      updateOverlay();
      wasPaused = playback.isPaused;
    }
  }

  onPlaybackChange(VideoPlayback? newPlayback) {
    playback?.removeListener(playbackListener);
    setState(() => playback = newPlayback);
    model.playback = newPlayback;
    if (newPlayback != null) {
      newPlayback.addListener(playbackListener);
    }
  }

  @override
  void dispose() {
    super.dispose();
    hideOverlayTimer?.cancel();
    playback?.removeListener(playbackListener);
  }
}
