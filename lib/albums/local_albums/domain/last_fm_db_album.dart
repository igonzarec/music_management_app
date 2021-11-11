import 'package:music_management_app/albums/local_albums/infrastructure/last_fm_album_db_operations.dart';

class LastFmDbAlbum {
  int? id;
  final int mbId;
  final String name;
  final String artist;
  final String image;

  LastFmDbAlbum({
    this.id,
    required this.mbId,
    required this.name,
    required this.artist,
    required this.image,
  });

  factory LastFmDbAlbum.fromMap(dynamic obj) {
    return LastFmDbAlbum(
      id: obj[LastFmAlbumOperations.albumId],
      mbId: obj[LastFmAlbumOperations.mbId],
      name: obj[LastFmAlbumOperations.name],
      artist: obj[LastFmAlbumOperations.artist],
      image: obj[LastFmAlbumOperations.image],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      LastFmAlbumOperations.mbId: mbId,
      LastFmAlbumOperations.name: name,
      LastFmAlbumOperations.artist: artist,
      LastFmAlbumOperations.image: image,
    };

    return map;
  }

  //TODO: create function to instantiate from LastFmAlbumDetails

  @override
  String toString() {
    return 'LastFmDbAlbum{'
        ' albumId: $id,'
        ' mbid: $mbId,'
        ' name: $name,'
        ' artist: $artist,'
        ' image: $image,'
        '}';
  }
}
