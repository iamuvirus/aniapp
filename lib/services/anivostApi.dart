import 'dart:convert';
import 'dart:typed_data';
import 'package:aniapp/models/animeModel.dart';
import 'package:http/http.dart' as http;

class ApiAnimevost {
  String baseUrl = 'https://api.animevost.org/v1';

  Future<List<Anime>> getLast(int page, int perPage) async {
    String url = '$baseUrl/last?page=$page&quantity=$perPage';

    final http.Response response = await http.get(url);
    var obj = ResponseLast.fromJson(responseHandling(response));
    return obj.data;
  }

  Future<List<AnimePlayItem>> playList(int id) async {
    String url = '$baseUrl/playlist';
    Map<String, int> body = {'id': id};
    String encodedBody = body.keys.map((key) => "$key=${body[key]}").join("&");

    http.Response response = await http.post(url,
        body: encodedBody,
        headers: {"Content-Type": "application/x-www-form-urlencoded"});

    List<AnimePlayItem> playList = List<AnimePlayItem>.from(
        responseHandling(response).map((x) => AnimePlayItem.fromJson(x)));
    return playList;
  }

  ///Попытка универсального обработчика ответа
  ///TODO разобраться что должно возвращаться
  dynamic responseHandling(http.Response response) {
    if (response.statusCode == 200) {
      Uint8List bytes = response.bodyBytes;
      String responseString = utf8.decode(bytes);
      dynamic jsonResponse = jsonDecode(responseString);
      return jsonResponse;
    } else {
      ///TODO Надо что-то тут делать
      throw Exception('Error http api');
    }
  }
}
