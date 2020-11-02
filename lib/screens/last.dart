import 'package:aniapp/bloc/anime_list_bloc/anime_bloc.dart';
import 'package:aniapp/bloc/anime_list_bloc/anime_event.dart';
import 'package:aniapp/bloc/anime_list_bloc/anime_state.dart';
import 'package:aniapp/models/animeModel.dart';
import 'package:aniapp/widgets/animeItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeList extends StatelessWidget {
  final List<Anime> _animeList = [];
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<AnimeBloc, AnimeState>(
        builder: (context, state) {
          if (state is AnimeInitialState ||
              state is AnimeLoadingState && _animeList.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AnimeLoadedState) {
            _animeList.addAll(state.animeList);
            context.bloc<AnimeBloc>().isFetching = false;
          } else if (state is AnimeErrorState) {
            return Center(child: Text('Error'));
          }
          return RefreshIndicator(
              onRefresh: () async {
                _animeList.clear();
                context.bloc<AnimeBloc>().add(AnimeRefreshEvent());
              },
              child: CustomScrollView(
                controller: _scrollController
                  ..addListener(() {
                    if (_scrollController.offset >=
                            _scrollController.position.maxScrollExtent - 300 &&
                        !context.bloc<AnimeBloc>().isFetching) {
                      context.bloc<AnimeBloc>()
                        ..isFetching = true
                        ..add(AnimeLoadEvent());
                    }
                  }),
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (c, i) => AnimeItem(_animeList[i]),
                      childCount: _animeList.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: context.bloc<AnimeBloc>().isFetching == true
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: SizedBox(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          )
                        : Container(),
                  ),
                ],
                physics: AlwaysScrollableScrollPhysics(),
              )
              /*      /* ListView.builder(
              itemBuilder: (context, index) {
                return AnimeItem(_animeList[index]);
              },
              itemCount: _animeList.length,
              controller: _scrollController
                ..addListener(() {
                  if (_scrollController.offset ==
                          _scrollController.position.maxScrollExtent &&
                      !context.bloc<AnimeBloc>().isFetching) {
                    context.bloc<AnimeBloc>()
                      ..isFetching = true
                      ..add(AnimeLoadEvent());
                  }
                }),
            ), */ */
              );
        },
      ),
    );
  }
}
