import 'package:aniapp/models/animeModel.dart';
import 'package:dio/dio.dart';

class ApiAnimevost {
  var dio = Dio();
  Future<List<Anime>> getLast(int page, int perPage) async {
    String url =
        'https://api.animevost.org/v1/last?page=$page&quantity=$perPage';
    final Response response = await dio.get(url);

    if (response.statusCode == 200) {
      var obj = ResponseLast.fromJson(response.data);
      return obj.data;
    } else {
      throw Exception('Error loading anime');
    }
  }

  Future<List<AnimePlayItem>> playList(int id) async {
    String url = 'https://api.animevost.org/v1/playlist';
    Map<String, String> body = {'id': id.toString()};
    String encodedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
    final Response response = await dio.post(url,
        data: encodedBody,
        options: Options(
            headers: {"Content-Type": "application/x-www-form-urlencoded"}));

    if (response.statusCode == 200) {
      List<AnimePlayItem> playList = List<AnimePlayItem>.from(
          response.data.map((x) => AnimePlayItem.fromJson(x)));
      return playList;
    } else {
      throw Exception('Error loading playlist');
    }
  }
}
