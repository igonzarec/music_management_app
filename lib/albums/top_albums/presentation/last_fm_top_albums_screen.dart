// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:music_management_app/albums/core/presentation/state_handler.dart';
import 'package:music_management_app/albums/details/presentation/last_fm_album_details_screen.dart';
import 'package:music_management_app/albums/top_albums/application/last_fm_top_albums_cubit.dart';
import 'package:music_management_app/albums/top_albums/application/last_fm_top_albums_state.dart';
import 'package:music_management_app/core/shared/widgets/last_fm_default_cover_album.dart';
import 'package:music_management_app/core/shared/widgets/last_fm_normal_cover_album.dart';

class LastFmTopAlbumsScreen extends StatelessWidget
    implements StateHandler<LastFmTopAlbumsState> {
  final String artistName;

  const LastFmTopAlbumsScreen({
    Key? key,
    required this.artistName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LastFmTopAlbumsCubit(artistName: artistName),
      child: BlocBuilder<LastFmTopAlbumsCubit, LastFmTopAlbumsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("$artistName - Top Albums"),
            ),
            body: stateHandlerWidget(state),
          );
        },
      ),
    );
  }

  @override
  Widget stateHandlerWidget(state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state.hasError) {
      return const Center(
        child: Text("There aren't any albums to be shown"),
      );
    }
    return state.albums.isNotEmpty
        ? GridView.builder(
            itemCount: state.albums.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              void onTap () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LastFmAlbumDetailsScreen(
                      artist: state.albums[index].artist,
                      name: state.albums[index].name,
                      album: state.albums[index],
                    ),
                  ),
                );
              }

              return state.albums[index].image.isNotEmpty
                  ? LastFmNormalCoverAlbum(
                      image: state.albums[index].image,
                      onTap: onTap
                    )
                  : LastFmDefaultCoverAlbum(
                      name: state.albums[index].name,
                      onTap: onTap
                    );
            },
          )
        : const SizedBox.shrink();
  }
}
