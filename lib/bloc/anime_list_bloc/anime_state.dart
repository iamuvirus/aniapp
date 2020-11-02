import 'package:aniapp/models/animeModel.dart';
import 'package:flutter/foundation.dart';

abstract class AnimeState {}

class AnimeInitialState extends AnimeState {}

class AnimeLoadingState extends AnimeState {}

class AnimeLoadedState extends AnimeState {
  List<Anime> animeList;
  AnimeLoadedState({@required this.animeList}) : assert(animeList != null);
}

class AnimeErrorState extends AnimeState {}
