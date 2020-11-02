import 'dart:async';

import 'package:aniapp/models/animeModel.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<AnimePlayListEvent, AnimePlayListState> {
  final AnimeRepository animeRepository;

  PlaylistBloc({@required this.animeRepository})
      : super(AnimePlayListInitialState());

  List<AnimePlayItem> playList = [];

  bool sortAsc = true;

  @override
  Stream<AnimePlayListState> mapEventToState(AnimePlayListEvent event) async* {
    if (event is AnimePlayListLoadEvent) {
      yield AnimePlayListLoadingState();
      try {
        playList.clear();
        playList.addAll(await animeRepository.fetchPlayList(id: event.id)
          ..sort((a, b) {
            var r = a.id.compareTo(b.id);
            if (r != 0) return r;
            return a.name.compareTo(b.name);
          }));
        yield AnimePlayListLoadedState(playList: playList);
      } catch (_) {
        yield AnimePlayListErrorState();
      }
    } else if (event is AnimePlayListSortEvent) {
      sortAsc = !sortAsc;

      if (sortAsc) {
        playList
          ..sort((a, b) {
            var r = a.id.compareTo(b.id);
            if (r != 0) return r;
            return a.name.compareTo(b.name);
          });
      } else {
        playList
          ..sort((b, a) {
            var r = a.id.compareTo(b.id);
            if (r != 0) return r;
            return a.name.compareTo(b.name);
          });
      }

      yield AnimePlayListLoadedState(playList: playList);
    }
  }
}
