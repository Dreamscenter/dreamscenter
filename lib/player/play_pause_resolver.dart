import 'package:dreamscenter/player/player_view_model.dart';

class PlayPauseResolver {
  PlayerViewModel viewModel;
  bool _skipNext = false;
  
  PlayPauseResolver(this.viewModel);

  void onPause() {
    if (_skipNext) {
      _skipNext = false;
      return;
    }
    viewModel.isPaused = true;
    viewModel.pauseEventsController.add(null);
  }
  
  void onPlay() {
    if (_skipNext) {
      _skipNext = false;
      return;
    }
    viewModel.isPaused = false;
    viewModel.playEventsController.add(null);
  }
  
  void skipNextPlayPause() {
    _skipNext = true;
  }
}
