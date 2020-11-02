part of 'videoplayer_bloc.dart';

@immutable
abstract class VideoPlayerState {}

class VideoplayerInitial extends VideoPlayerState {}

class VideoplayerShowOverlay extends VideoPlayerState {}

class VideoplayerHideOverlay extends VideoPlayerState {}
