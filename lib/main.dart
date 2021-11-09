import 'package:flutter/material.dart';
import 'package:music_management_app/albums/core/infrastructure/last_fm_network_top_albums_repository.dart';
import 'package:music_management_app/albums/core/infrastructure/last_fm_network_tracks_repository.dart';
import 'package:music_management_app/search_artists/infrastructure/last_fm_artists_repository.dart';

void main() async {
  ///get artists
  // LastFmArtistsRepository().getArtists("avril", 1, 30);
  ///get albums
  // LastFmNetworkTopAlbumsRepository()
  //     .getTopAlbums("Linkin Park")
  //     .then((value) => value.forEach((element) {
  //           print(element?.name);
  //         }));
  ///get tracks
  // LastFmNetworkTracksRepository()
  //     .getTracks("linkin park", "meteora")
  //     .then((value) => value.forEach((element) {
  //           print(element);
  //         }));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> getArtistsByName() async {}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
