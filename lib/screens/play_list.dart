import 'package:aniapp/bloc/play_list_bloc/playlist_bloc.dart';
import 'package:aniapp/models/animeModel.dart';
import 'package:aniapp/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayList extends StatelessWidget {
  final List<AnimePlayItem> _animeList = [];
  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = new ScrollController();
    return Center(
      child: BlocBuilder<PlaylistBloc, AnimePlayListState>(
          builder: (context, state) {
        if (state is AnimePlayListInitialState ||
            state is AnimePlayListLoadingState) {
          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is AnimePlayListLoadedState) {
          _animeList.addAll(state.playList);
        } else if (state is AnimePlayListErrorState) {
          return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(child: Text('Error')));
        }
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            ),
          ),
          body: GridView.builder(
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemCount: _animeList.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnimeVideoPlayer(
                                  playItem: _animeList[index],
                                )),
                      );
                    },
                    child: Card(
                        child: Center(child: Text(_animeList[index].name))));
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              );
            },
            child: Icon(Icons.arrow_downward),
          ),
        );
      }),
    );
  }
}
