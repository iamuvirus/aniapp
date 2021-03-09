class ResponseLast {
  StateResponse state;
  List<Anime> data;

  ResponseLast({this.state, this.data});

  ResponseLast.fromJson(Map<String, dynamic> json) {
    state = json['state'] != null
        ? new StateResponse.fromJson(json['state'])
        : null;
    if (json['data'] != null) {
      data = new List<Anime>.empty(growable: true);
      json['data'].forEach((v) {
        data.add(new Anime.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.state != null) {
      data['state'] = this.state.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StateResponse {
  String status;
  int rek;
  int page;
  int count;

  StateResponse({this.status, this.rek, this.page, this.count});

  StateResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    rek = json['rek'];
    page = json['page'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['rek'] = this.rek;
    data['page'] = this.page;
    data['count'] = this.count;
    return data;
  }
}

class Anime {
  List<String> screenImage;
  int rating;
  String description;
  String series;
  String director;
  String urlImagePreview;
  String year;
  String genre;
  int id;
  int votes;
  int isFavorite;
  String rusTitle;
  String engTitle;
  String otherInfo;
  String timer;
  String type;
  int isLikes;

  Anime(
      {this.screenImage,
      this.rating,
      this.description,
      this.series,
      this.director,
      this.urlImagePreview,
      this.year,
      this.genre,
      this.id,
      this.votes,
      this.isFavorite,
      this.engTitle,
      this.rusTitle,
      this.otherInfo,
      this.timer,
      this.type,
      this.isLikes});

  Anime.fromJson(Map<String, dynamic> json) {
    screenImage = json['screenImage'].cast<String>();
    rating = json['rating'];
    description = json['description'];
    series = json['series'];
    director = json['director'];
    urlImagePreview = json['urlImagePreview'];
    year = json['year'];
    genre = json['genre'];
    id = json['id'];
    votes = json['votes'];
    isFavorite = json['isFavorite'];
    rusTitle = (json['title']).toString().split(" / ")[0];
    engTitle = (json['title']).toString().split(" / ")[1].split(" [")[0];
    otherInfo = "[" + (json['title']).toString().split(" / ")[1].split(" [")[1];
    type = json['type'];
    isLikes = json['isLikes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['screenImage'] = this.screenImage;
    data['rating'] = this.rating;
    data['description'] = this.description;
    data['series'] = this.series;
    data['director'] = this.director;
    data['urlImagePreview'] = this.urlImagePreview;
    data['year'] = this.year;
    data['genre'] = this.genre;
    data['id'] = this.id;
    data['votes'] = this.votes;
    data['isFavorite'] = this.isFavorite;
    data['timer'] = this.timer;
    data['type'] = this.type;
    data['isLikes'] = this.isLikes;
    return data;
  }
}

class AnimePlayItem {
  String std;
  String preview;
  String name;
  String hd;
  int id;

  AnimePlayItem({this.std, this.preview, this.name, this.hd});
  RegExp exp = new RegExp(r"^[0-9]+");
  AnimePlayItem.fromJson(Map<String, dynamic> json) {
    std = json['std'];
    preview = json['preview'];
    name = json['name'];
    hd = json['hd'];

    if (exp.hasMatch(json['name'])) {
      id = int.parse(exp.stringMatch(json['name']));
    } else {
      id = 0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['std'] = this.std;
    data['preview'] = this.preview;
    data['name'] = this.name;
    data['hd'] = this.hd;
    data['id'] = this.id;
    return data;
  }
}
