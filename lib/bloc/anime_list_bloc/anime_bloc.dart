import 'package:aniapp/models/animeModel.dart';
import 'package:aniapp/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aniapp/bloc/anime_list_bloc/anime_event.dart';
import 'package:aniapp/bloc/anime_list_bloc/anime_state.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  final AnimeRepository animeRepository;

  AnimeBloc({@required this.animeRepository}) : super(AnimeInitialState());

  int page = 1;
  bool isFetching = false;

  @override
  Stream<AnimeState> mapEventToState(AnimeEvent event) async* {
    if (event is AnimeLoadEvent || event is AnimeRefreshEvent) {
      if (event is AnimeRefreshEvent) {
        page = 1;
      }
      yield AnimeLoadingState();
      try {
        final List<Anime> _animeList =
            await animeRepository.fetchNext(page: page);
        page++;
        yield AnimeLoadedState(animeList: _animeList);
      } catch (_) {
        yield AnimeErrorState();
      }
    }
  }
}
