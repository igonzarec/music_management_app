// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:music_management_app/albums/core/domain/last_fm_album.dart';
import 'package:music_management_app/albums/core/presentation/state_handler.dart';
import 'package:music_management_app/albums/details/application/last_fm_album_details_cubit.dart';
import 'package:music_management_app/albums/details/application/last_fm_album_details_state.dart';
import 'package:music_management_app/albums/details/application/last_fm_album_star_cubit.dart';
import 'package:music_management_app/albums/local_albums/application/last_fm_local_albums_bloc.dart';
import 'package:music_management_app/albums/local_albums/application/last_fm_local_albums_event.dart';

import 'package:music_management_app/core/shared/asset_constants.dart'
    as assets;

class LastFmAlbumDetailsScreen extends StatelessWidget
    implements StateHandler<LastFmAlbumDetailsState> {
  const LastFmAlbumDetailsScreen(
      {Key? key, required this.name, required this.artist, required this.album})
      : super(key: key);

  final String name;
  final String artist;
  final LastFmAlbum album;

  AppBar buildDefaultAppBar() {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          name,
          textScaleFactor: 1,
          style: const TextStyle(
            fontFamily: 'MontserratAlternates',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LastFmAlbumDetailsCubit(album),
      child: BlocBuilder<LastFmAlbumDetailsCubit, LastFmAlbumDetailsState>(
        builder: (context, state) {
          return stateHandlerWidget(state);
        },
      ),
    );
  }

  @override
  Widget stateHandlerWidget(LastFmAlbumDetailsState state) {
    if (state.isLoading) {
      return Scaffold(
        appBar: buildDefaultAppBar(),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (state.hasError) {
      return Scaffold(
        appBar: buildDefaultAppBar(),
        body: const Center(
          child: Text("There aren't any albums to be shown"),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        state.albumDetails!.name,
                        textScaleFactor: 1,
                        maxLines: 3,
                        style: const TextStyle(
                          fontFamily: 'MontserratAlternates',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    //VALIDATE IF ALBUM IS LIKED
                    Builder(builder: (context) {
                      context
                          .read<LastFmAlbumStarCubit>()
                          .checkAlbumStatus(album);
                      final starState =
                          context.watch<LastFmAlbumStarCubit>().state;
                      return GestureDetector(
                          child: starState.isLiked
                              ? Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(10),
                                child: const Icon(
                                    Icons.star,
                                    color: Colors.white,
                                  ),
                              )
                              : Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(10),
                                child: const Icon(
                                    Icons.star_border,
                                    color: Colors.white,
                                  ),
                              ),
                          onTap: starState.isLiked
                              ? () async {
                                  await context
                                      .read<LastFmAlbumStarCubit>()
                                      .unStarAlbum(
                                          albumDetails: state.albumDetails);
                                  context
                                      .read<LastFmLocalAlbumsBloc>()
                                      .add(LocalAlbumsQuery());
                                }
                              : () async {
                                  await context
                                      .read<LastFmAlbumStarCubit>()
                                      .starAlbum(
                                          albumDetails: state.albumDetails);
                                  context
                                      .read<LastFmLocalAlbumsBloc>()
                                      .add(LocalAlbumsQuery());
                                });
                    }),
                  ],
                ),
              ),
              background: state.albumDetails!.image.isNotEmpty
                  ? Image.network(
                      state.albumDetails!.image,
                      // 'assets/place_holders/album_placeholder.jpg',
                      fit: BoxFit.fitWidth,
                      color: Colors.black.withOpacity(.5),
                      colorBlendMode: BlendMode.darken,
                    )
                  : Image.asset(
                      assets.stylusAlbumPlaceholder,
                      fit: BoxFit.fill,
                      color: Colors.redAccent.withOpacity(.8),
                      colorBlendMode: BlendMode.modulate,
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(left: 40),
              alignment: Alignment.centerLeft,
              child: Text(
                "Artist: ${state.albumDetails!.artist}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              height: 50,
              width: 50,
            ),
          ),
          state.albumDetails!.tracks.isNotEmpty
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, int index) {
                      return ListTile(
                        leading: Container(
                            padding: const EdgeInsets.all(8),
                            width: 100,
                            child: Text('Track ${index + 1}')),
                        title: Text(state.albumDetails!.tracks[index],
                            textScaleFactor: 1.2),
                      );
                    },
                    childCount: state.albumDetails!.tracks.length,
                  ),
                )
              : SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Text("Single : ${state.albumDetails!.name}"),
                  ),
                ),
        ],
      ),
    );
  }
}
