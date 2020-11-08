import 'package:aniapp/services/anivostApi.dart';
import 'package:flutter/foundation.dart';

import 'models/animeModel.dart';

class AnimeRepository {
  static final AnimeRepository _animeRepository = AnimeRepository._();
  static final ApiAnimevost _apiAnimevost = new ApiAnimevost();
  static const int _perPage = 25;
  AnimeRepository._();

  factory AnimeRepository() {
    return _animeRepository;
  }

  Future<List<Anime>> fetchNext({@required int page}) async {
    return _apiAnimevost.getLast(page, _perPage);
  }

  Future<List<AnimePlayItem>> fetchPlayList({@required int id}) async {
    return _apiAnimevost.playList(id);
  }

  Future<Anime> fetchinfo({@required int id}) async {
    return _apiAnimevost.info(id);
  }
}
