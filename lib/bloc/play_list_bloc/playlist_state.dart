part of 'playlist_bloc.dart';

abstract class AnimePlayListState {}

class AnimePlayListInitialState extends AnimePlayListState {}

class AnimePlayListLoadingState extends AnimePlayListState {}

class AnimePlayListLoadedState extends AnimePlayListState {
  List<AnimePlayItem> playList;
  AnimePlayListLoadedState({@required this.playList})
      : assert(playList != null);
}

class AnimePlayListErrorState extends AnimePlayListState {}
