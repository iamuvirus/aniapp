import 'package:aniapp/bloc/play_list_bloc/playlist_bloc.dart';
import 'package:aniapp/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BlocBuilder<PlaylistBloc, AnimePlayListState>(
            builder: (context, state) {
          if (state is AnimePlayListInitialState ||
              state is AnimePlayListLoadingState &&
                  context.bloc<PlaylistBloc>().playList.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AnimePlayListLoadedState) {
          } else if (state is AnimePlayListErrorState) {
            return Center(child: Text('Error'));
          }
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemCount: context.bloc<PlaylistBloc>().playList.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnimeVideoPlayer(
                                  playItem: context
                                      .bloc<PlaylistBloc>()
                                      .playList[index],
                                )),
                      );
                    },
                    child: Card(
                        child: Center(
                            child: Text(context
                                .bloc<PlaylistBloc>()
                                .playList[index]
                                .name))));
              });
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.bloc<PlaylistBloc>().add(AnimePlayListSortEvent());
        },
        child: Icon(Icons.sort),
      ),
    );
  }
}
