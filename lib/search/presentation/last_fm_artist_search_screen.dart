// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:music_management_app/albums/core/presentation/state_handler.dart';
import 'package:music_management_app/albums/top_albums/presentation/last_fm_top_albums_screen.dart';
import 'package:music_management_app/search/application/last_fm_artist_bloc.dart';
import 'package:music_management_app/search/application/last_fm_artist_search_state.dart';

class LastFmArtistSearchScreen extends StatelessWidget
    implements StateHandler<LastFmArtistSearchState> {
  // final Bloc<LastFmArtistSearchEvent, LastFmArtistSearchState> artistBloc;
  final _artistBloc = LastFmArtistBloc(LastFmArtistSearchState.initial());
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              autofocus: true,
              onChanged: (value) {
                //Note: the is a bug originated when typing with the keyboard.
                //for more info check this still open issue: https://github.com/flutter/flutter/issues/9471
                _artistBloc.getArtists(artist: value);
              },
              controller: _controller,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: BlocBuilder(
        bloc: _artistBloc,
        builder: (BuildContext context, LastFmArtistSearchState state) {
          return stateHandlerWidget(state);
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
        child: Text("There aren't any artists to be shown"),
      );
    }
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.music_note),
          title: Text(state.artists[index].name),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LastFmTopAlbumsScreen(
                  artistName: state.artists[index].name,
                ),
              ),
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
      itemCount: state.artists.length,
    );
  }
}
