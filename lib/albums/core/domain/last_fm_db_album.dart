import 'dart:developer';

import 'package:music_management_app/albums/local_albums/infrastructure/last_fm_album_db_operations.dart';

class LastFmDbAlbum {
  int? albumId;
  String? name;
  String? artist;
  String? image;

  LastFmDbAlbum({
    this.albumId,
    this.name,
    this.artist,
    this.image,
  }) {
    log("LastFmDbAlbum created");
  }

  LastFmDbAlbum.fromMap(dynamic obj) {
    albumId = obj[LastFmAlbumOperations.albumId];
    name = obj[LastFmAlbumOperations.name];
    artist = obj[LastFmAlbumOperations.artist];
    image = obj[LastFmAlbumOperations.image];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      LastFmAlbumOperations.name: name,
      LastFmAlbumOperations.artist: artist,
      LastFmAlbumOperations.image: image,
    };

    return map;
  }
}
