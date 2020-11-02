import 'dart:math';

import 'package:aniapp/bloc/video_player_bloc/videoplayer_bloc.dart';
import 'package:aniapp/models/animeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class AnimeVideoPlayer extends StatefulWidget {
  final AnimePlayItem playItem;

  AnimeVideoPlayer({this.playItem});

  @override
  _AnimeVideoPlayerState createState() => _AnimeVideoPlayerState(playItem);
}

class _AnimeVideoPlayerState extends State<AnimeVideoPlayer> {
  AnimePlayItem playItem;
  VideoPlayerController _controller;

  _AnimeVideoPlayerState(this.playItem);

  @override
  void initState() {
    _controller = VideoPlayerController.network(playItem.hd);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(false);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Wakelock.enable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Center(
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(_controller),
                _ControlsOverlay(
                  controller: _controller,
                  playItem: playItem,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Wakelock.disable();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    _controller.dispose();
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key key, this.controller, this.playItem})
      : super(key: key);

  final VideoPlayerController controller;
  final AnimePlayItem playItem;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoPlayerBloc()..add(ToggleOverlayEvent()),
      child: BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
          builder: (context, state) {
        return Container(
          child: GestureDetector(
            child: state is VideoplayerShowOverlay
                ? Container(
                    color: Colors.black54,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom: 0, left: 50, top: 0, right: 0),
                            child: GestureDetector(
                              onTap: () {
                                controller.seekTo(controller.value.position +
                                    Duration(seconds: -10));
                              },
                              child: Transform.rotate(
                                angle: 180 * pi / 180,
                                child: Icon(
                                  Icons.double_arrow,
                                  color: Colors.white,
                                  size: 100.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom: 0, left: 0, top: 0, right: 50),
                            child: GestureDetector(
                              onTap: () {
                                controller.seekTo(controller.value.position +
                                    Duration(seconds: 10));
                              },
                              child: Icon(
                                Icons.double_arrow,
                                color: Colors.white,
                                size: 100.0,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  controller.value.isPlaying
                                      ? controller.pause()
                                      : controller.play();
                                },
                                child: Icon(
                                  controller.value.isPlaying
                                      ? Icons.play_arrow
                                      : Icons.pause,
                                  color: Colors.white,
                                  size: 100.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              playItem.name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: VideoProgressIndicator(controller,
                              padding: EdgeInsets.all(10),
                              allowScrubbing: true),
                        ),
                      ],
                    ),
                  )
                : Container(color: Colors.transparent),
            onTap: () {
              context.bloc<VideoPlayerBloc>().add(ToggleOverlayEvent());
            },
          ),
        );
      }),
    );
  }

/*   @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoplayerBloc, VideoplayerState>(
      builder: (context, state) {
        return Stack(
          children: <Widget>[
            !controller.value.isPlaying
                ? Container(
                    color: Colors.black,
                    child: Text(
                      playItem.name,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                : Container(),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 50),
              reverseDuration: Duration(milliseconds: 200),
              child: controller.value.isPlaying
                  ? SizedBox.shrink()
                  : Container(
                      color: Colors.black54,
                      child: Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 100.0,
                        ),
                      ),
                    ),
            ),
            GestureDetector(
              onTap: () {
                /*   controller.value.isPlaying ? controller.pause() : controller.play(); */
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: PopupMenuButton<String>(
                initialValue: controller.dataSource,
                tooltip: 'Playback speed',
                onSelected: (src) {},
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: playItem.hd,
                      child: Text('HD'),
                    ),
                    PopupMenuItem(
                      value: playItem.std,
                      child: Text('SD'),
                    )
                  ];
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      // Using less vertical padding as the text is also longer
                      // horizontally, so it feels like it would need more spacing
                      // horizontally (matching the aspect ratio of the video).
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        );
      },
    );
  } */
}
