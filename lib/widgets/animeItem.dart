import 'package:aniapp/bloc/play_list_bloc/playlist_bloc.dart';
import 'package:aniapp/models/animeModel.dart';
import 'package:aniapp/screens/play_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeItem extends StatelessWidget {
  final Anime anime;

  const AnimeItem(this.anime);

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 1.0,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: InkWell(
        onTap: () {
          context
              .bloc<PlaylistBloc>()
              .add(AnimePlayListLoadEvent(id: anime.id));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlayList()),
          );
        },
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 3, bottom: 3, top: 3, right: 0),
              child: new Container(
                margin: const EdgeInsets.only(right: 15.0),
                width: 105.75,
                height: 150.0,
                child: new Image.network(anime.urlImagePreview),
              ),
            ),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Container(
                          margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: new Text(
                            anime.engTitle,
                            style: new TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        child: new Text(
                          (anime.rating / anime.votes).toStringAsFixed(1),
                          style: new TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Container(
                          margin: const EdgeInsets.only(top: 0.0, bottom: 5.0),
                          child: new Text(
                            anime.rusTitle,
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Container(
                          margin: const EdgeInsets.only(top: 0.0, bottom: 5.0),
                          child: new Text(
                            anime.otherInfo,
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Container(
                          margin: const EdgeInsets.only(top: 0.0, bottom: 5.0),
                          child: new Text(
                            anime.genre,
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Row(
                      children: <Widget>[
                        new Text(
                          "Год:",
                          style: new TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12.0,
                          ),
                        ),
                        new Container(
                            margin: const EdgeInsets.only(left: 5.0),
                            child: new Text(
                              anime.year,
                              style: new TextStyle(
                                fontSize: 12.0,
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
