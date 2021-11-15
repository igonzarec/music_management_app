// Project imports:
import 'package:music_management_app/albums/core/domain/last_fm_album.dart';
import 'package:music_management_app/albums/local_albums/infrastructure/last_fm_album_db_operations.dart';

class LastFmLocalAlbum extends LastFmAlbum {
  int? id;
  final String mbid;
  final String name;
  final String artist;
  final String image;

  LastFmLocalAlbum({
    this.id,
    required this.mbid,
    required this.name,
    required this.artist,
    required this.image,
  });

  factory LastFmLocalAlbum.fromMap(dynamic obj) {
    return LastFmLocalAlbum(
      id: obj[LastFmDbAlbumOperations.albumId],
      mbid: obj[LastFmDbAlbumOperations.mbId],
      name: obj[LastFmDbAlbumOperations.name],
      artist: obj[LastFmDbAlbumOperations.artist],
      image: obj[LastFmDbAlbumOperations.image],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      LastFmDbAlbumOperations.mbId: mbid,
      LastFmDbAlbumOperations.name: name,
      LastFmDbAlbumOperations.artist: artist,
      LastFmDbAlbumOperations.image: image,
    };

    return map;
  }

  @override
  String toString() {
    return 'LastFmLocalAlbum{'
        ' albumId: $id,'
        ' mbid: $mbid,'
        ' name: $name,'
        ' artist: $artist,'
        ' image: $image,'
        '}';
  }
}
