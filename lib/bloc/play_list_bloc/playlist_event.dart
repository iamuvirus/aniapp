part of 'playlist_bloc.dart';

abstract class AnimePlayListEvent {}

class AnimePlayListLoadEvent extends AnimePlayListEvent {
  final int id;
  AnimePlayListLoadEvent({@required this.id});
}

class AnimePlayListSortEvent extends AnimePlayListEvent {}
