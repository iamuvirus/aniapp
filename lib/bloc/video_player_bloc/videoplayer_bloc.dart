import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'videoplayer_event.dart';
part 'videoplayer_state.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  VideoPlayerBloc() : super(VideoplayerInitial());

  bool _overlayShow = true;

  @override
  Stream<VideoPlayerState> mapEventToState(
    VideoPlayerEvent event,
  ) async* {
    if (event is ToggleOverlayEvent) {
      if (_overlayShow) {
        _overlayShow = false;
        yield VideoplayerHideOverlay();
      } else {
        _overlayShow = true;
        yield VideoplayerShowOverlay();
      }
    }
  }
}
