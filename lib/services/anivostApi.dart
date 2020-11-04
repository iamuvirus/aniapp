import 'dart:convert';
import 'package:aniapp/models/animeModel.dart';
import 'package:http/http.dart' as http;

class ApiAnimevost {
  Future<List<Anime>> getLast(int page, int perPage) async {
    String url =
        'https://api.animevost.org/v1/last?page=$page&quantity=$perPage';
    final http.Response response = await http.get(url);

    var bytes = response.bodyBytes;
    String responseString = utf8.decode(bytes);
    var jsonResponse = jsonDecode(responseString);
    if (response.statusCode == 200) {
      var obj = ResponseLast.fromJson(jsonResponse);
      return obj.data;
    } else {
      throw Exception('Error loading anime');
    }
  }

  Future<List<AnimePlayItem>> playList(int id) async {
    String url = 'https://api.animevost.org/v1/playlist';
    Map<String, String> body = {'id': id.toString()};
    String encodedBody = body.keys.map((key) => "$key=${body[key]}").join("&");

    var response = await http.post(url,
        body: encodedBody,
        headers: {"Content-Type": "application/x-www-form-urlencoded"});

    var bytes = response.bodyBytes;
    String responseString = utf8.decode(bytes);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(responseString);

      List<AnimePlayItem> playList = List<AnimePlayItem>.from(
          jsonResponse.map((x) => AnimePlayItem.fromJson(x)));
      return playList;
    } else {
      throw Exception('Error loading playlist');
    }
  }
}
