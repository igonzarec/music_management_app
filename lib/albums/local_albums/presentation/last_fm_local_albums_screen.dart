// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:music_management_app/albums/core/presentation/state_handler.dart';
import 'package:music_management_app/albums/details/presentation/last_fm_album_details_screen.dart';
import 'package:music_management_app/albums/local_albums/application/last_fm_local_albums_bloc.dart';
import 'package:music_management_app/albums/local_albums/application/last_fm_local_albums_state.dart';
import 'package:music_management_app/core/shared/widgets/last_fm_default_cover_album.dart';
import 'package:music_management_app/search/presentation/last_fm_artist_search_screen.dart';

class LastFmLocalAlbumsScreen extends StatelessWidget
    implements StateHandler<LastFmLocalAlbumsState> {
  const LastFmLocalAlbumsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My albums"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.search),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LastFmArtistSearchScreen()));
        },
        label: const Text("Search top albums!"),
      ),
      body: Builder(
        builder: (context) {
          final state = context.watch<LastFmLocalAlbumsBloc>().state;
          return stateHandlerWidget(state);
        },
      ),
    );
  }

  @override
  Widget stateHandlerWidget(state) {
    //initial
    if (state is LocalAlbumsInitial) {
      return Container();
    }
    //load in progress
    if (state is LocalAlbumsLoadInProgress) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    //load success
    if (state is LocalAlbumsLoadSuccess) {
      return state.albums.isNotEmpty
          ? GridView.builder(
              itemCount: state.albums.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return LastFmDefaultCoverAlbum(
                  name: state.albums[index].name,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LastFmAlbumDetailsScreen(
                          artist: state.albums[index].artist,
                          name: state.albums[index].name,
                          album: state.albums[index],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Search for albums, like them and find them in this screen!",
                  textAlign: TextAlign.center,
                ),
              ),
            );
    }
    //load failed
    return Center(
      child: Text(
        (state as LocalAlbumsLoadFailed).error.toString(),
      ),
    );
  }
}
