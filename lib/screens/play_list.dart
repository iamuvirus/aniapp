import 'package:aniapp/bloc/play_list_bloc/playlist_bloc.dart';
import 'package:aniapp/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayList extends StatelessWidget {
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
        } else if (state is AnimePlayListErrorState) {
          return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(child: Text('Error')));
        }
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.watch<PlaylistBloc>().anime.engTitle),
                  Text(context.watch<PlaylistBloc>().anime.rusTitle)
                ],
              ),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "Серии",
                  ),
                  Tab(text: "Описание"),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                GridView.builder(
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    itemCount: context.watch<PlaylistBloc>().playList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AnimeVideoPlayer(
                                        playItem: context
                                            .watch<PlaylistBloc>()
                                            .playList[index],
                                      )),
                            );
                          },
                          child: Card(
                              child: Center(
                                  child: Text(context
                                      .watch<PlaylistBloc>()
                                      .playList[index]
                                      .name))));
                    }),
                Card(
                  child: Text(context.watch<PlaylistBloc>().anime.description),
                )
              ],
            ),
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
          ),
        );
      }),
    );
  }
}
