import 'package:aniapp/bloc/anime_list_bloc/anime_bloc.dart';
import 'package:aniapp/bloc/anime_list_bloc/anime_event.dart';
import 'package:aniapp/bloc/play_list_bloc/playlist_bloc.dart';
import 'package:aniapp/repository.dart';
import 'package:aniapp/screens/home.dart';
import 'package:aniapp/screens/play_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AnimeBloc(animeRepository: AnimeRepository())
            ..add(AnimeLoadEvent()),
        ),
        BlocProvider(
            create: (context) =>
                PlaylistBloc(animeRepository: AnimeRepository())),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => Home(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/second': (context) => PlayList(),
        },
      ),
    );
  }
}
